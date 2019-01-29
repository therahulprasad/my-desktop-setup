sudo apt update
sudo apt -y install git curl vim snapd

# Configure terminal from https://github.com/therahulprasad/my-terminal-configuration
sh -c "$(curl -fsSL https://raw.githubusercontent.com/therahulprasad/my-terminal-configuration/master/init.sh)"

# Configure vim from https://github.com/therahulprasad/my-vim-configulation
sh -c "$(curl -fsSL https://raw.githubusercontent.com/therahulprasad/my-vim-configulation/master/install.sh)"

# Install basic applications, IDEs and tools
sudo snap install sublime-text atom skype firefox android-studio
sudo snap install docker gitkraken
