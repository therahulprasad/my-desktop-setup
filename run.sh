sudo apt update
sudo apt -y install git curl vim

# Configure terminal from https://github.com/therahulprasad/my-terminal-configuration
sh -c "$(curl -fsSL https://raw.githubusercontent.com/therahulprasad/my-terminal-configuration/master/init.sh)"

# Configure vim from https://github.com/therahulprasad/my-vim-configulation
sh -c "$(curl -fsSL https://raw.githubusercontent.com/therahulprasad/my-vim-configulation/master/install.sh)"
