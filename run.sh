#!/bin/bash
# Assuming its a debian based system
echo "What do you want me to do ? (setup-base; setup-jenkins)"
read TODO

if [ $TODO == "setup-base" ]; then
  ls $HOME/Development || mkdir $HOME/Development
  ls $HOME/Development/go || mkdir $HOME/Development/go

  sudo apt update
  sudo apt -y install git curl vim snapd python3-pip adb 
  sudo apt -y install ncdu ecryptfs-utils openssh-server 

  # Configure terminal from https://github.com/therahulprasad/my-terminal-configuration
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/therahulprasad/my-terminal-configuration/master/init.sh)"

  # Configure vim from https://github.com/therahulprasad/my-vim-configulation
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/therahulprasad/my-vim-configulation/master/install.sh)"

  # Install basic applications, IDEs and tools
  sudo snap install sublime-text atom skype firefox android-studio
  sudo snap install docker gitkraken
  
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
