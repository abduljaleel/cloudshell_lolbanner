cd ~/
sudo yum install ruby -y
sudo amazon-linux-extras install epel -y  > /dev/null 2>&1
sudo yum install figlet -y
echo "ruby version"
ruby --version

if [ -f ~/master.zip ]
then
    echo "lolcat master.zip already download"
else
    echo "Next download and install the most recent version of lolcat from the git repository using following commands"
    wget https://github.com/busyloop/lolcat/archive/master.zip
    unzip master.zip
    cd lolcat-master/bin
fi

echo "gem install lolcat"
gem install lolcat > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "gem install lolcat Success"
fi

echo "Testing lolcat"
lolcat --version
ps | lolcat

echo "Download figlet-fonts art fonts "
mkdir -p ~/.local/share/fonts/figlet-fonts/
cd ~/.local/share/fonts/figlet-fonts
wget https://raw.githubusercontent.com/xero/figlet-fonts/master/3d.flf

cat > ~/lolbanner << EOF
#!/bin/bash
input=\$*
function lolbanner(){
   echo ""
   figlet -c -f ~/.local/share/fonts/figlet-fonts/3d.flf \$input | lolcat
   echo ""
}
lolbanner
EOF

chmod +x ~/lolbanner

echo 'alias lolbanner='$HOME/lolbanner'' >> ~/.bashrc
source ~/.bashrc
bash ~/lolbanner Hello AWS CloudShell