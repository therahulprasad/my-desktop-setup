#!/bin/bash
# Assuming its a debian based system
echo "What do you want me to do ? (setup-base; setup-jenkins)"
read TODO

if [ $TODO == "setup-base" ]; then
  ls $HOME/Development || mkdir $HOME/Development
  ls $HOME/Development/go || mkdir $HOME/Development/go

  sudo apt update
  sudo apt -y install git curl vim snapd python3-pip ipython3 adb 
  sudo apt -y install ncdu ecryptfs-utils openssh-server meld
  sudo apt -y install openjdk-11-jdk network-manager-openvpn-gnome 
  sudo apt -y install php mysql-client pv
  
  # Configure terminal from https://github.com/therahulprasad/my-terminal-configuration
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/therahulprasad/my-terminal-configuration/master/init.sh)"

  # Configure vim from https://github.com/therahulprasad/my-vim-configulation
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/therahulprasad/my-vim-configulation/master/install.sh)"

  # Install basic applications, IDEs and tools
  sudo snap install sublime-text atom skype firefox android-studio
  sudo snap install docker gitkraken jq gimp ffmpeg spotify
  sudo snap install vscode --classic
  
  # Install gvm
  sudo apt install bison 
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
  [[ -s "\$HOME/.gvm/scripts/gvm" ]] && source "\$HOME/.gvm/scripts/gvm"
  gvm install go1.4 -B # This is needed for building upstream version from source code
  gvm use go1.4 # Set it as default
  export GOROOT_BOOTSTRAP=$GOROOT
  gvm install go1.11.5 # TODO: Install latest version or take it as an argument
  gvm use go1.11.5 # Use currently installed version of GO
  echo "export GOPATH=\$HOME/Development/go" >> $HOME/.zshrc
  echo "export PATH=\$PATH:$GOROOT/bin:\$GOPATH/bin" >> $HOME/.zshrc
  
  # AWSCLI
  pip3 install awscli
  
  # nvm
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  echo "Apparently it does not add to zshrc you you have to manually add configurations to zshrc"
  echo "Once that is done install nodejs using nvm install --lts"
  
  #gsutils
  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  sudo apt-get update && sudo apt -y install google-cloud-sdk
fi

if [ $TODO == "setup-jenkins" ]; then
  # Setup Jenkins
  ls $HOME/jenkins_home || mkdir $HOME/jenkins_home
  echo "Copy old jenkins home data to $HOME/jenkins_home folder and press any key" && read ANS;
  
  # TODO: Fix me (This is a hack to save from permission issues as jenkins users from docker might now be able to access this folder)
  chmod 777 $HOME/jenkins_home # IF this does not work try sudo chmod -R 777 $HOME/jenkins_home
  sudo docker run -v $HOME/jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
  
  if which xdg-open > /dev/null
  then
    xdg-open "http://localhost:8080/"
  elif which gnome-open > /dev/null
  then
    gnome-open "http://localhost:8080/"
  fi
  
  # If installing from scratch install these plugins as well
  # Install popular plugins
  # Install android-emulator
fi
