#!/bin/bash

BOLD=$(tput bold)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)

ARROW="$CYAN$BOLD==>$DEFAULT"
ARROW_YELLOW="$YELLOW$BOLD==>$DEFAULT"

BREW_APPLICATIONS=(jq git zsh zsh-completions zsh-syntax-highlighting)
CASK_APPLICATIONS=(google-chrome postman slack sourcetree visual-studio-code docker evernote iterm2 android-file-transfer the-unarchiver)
VS_CODE_EXTENSIONS=(eamodio.gitlens donjayamanne.githistory esbenp.prettier-vscode VisualStudioExptTeam.vscodeintellicode)
NPM_GLOBAL_MODULES=(typescript ts-node pm2)

#----------
# Homebrew
#----------
if $IS_HOMEBREW_INSTALLED; then
    # brew update
    # brew upgrade
    echo "Homebrew is already installed"
else 
    echo "${ARROW} Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#-------------------
# Brew applications
#-------------------
for application in "${BREW_APPLICATIONS[@]}"; do
    echo "${ARROW} Installing ${application} via Homebrew..."
    brew install ${application}
done

#-------------------
# Cask applications
#-------------------
for application in "${CASK_APPLICATIONS[@]}"; do
    echo "${ARROW} Installing ${application} via Homebrew cask..."
    brew cask install ${application}
done

#------------------------------------
# VS Code Configuration & Extensions
#------------------------------------
for extension in "${VS_CODE_EXTENSIONS[@]}"; do
    echo "${ARROW} Installing ${extension} to VS Code..."
    code --install-extension ${extension}
done

#--------
# iTerm2 & Zsh
#--------

# Oh my Zsh
echo "${ARROW} Installing Oh my Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Powerlevel10k
echo "${ARROW} Installing Powerlevel10k..."
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

echo "${ARROW} Installing Zsh autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

cp .zshrc ~

#------------------------------
# NVM & Node & Global Packages
#------------------------------

#NVM
if ! [ -x "$(command -v nvm)" ]; then
    echo "NVM is already installed"
else
    echo "${ARROW} Installing Node version manager..."
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    source ~/.bash_profile  
fi

# Node
if hash node; then
    echo "Node is already installed"
else
    echo "${ARROW} Installing Node..."
    nvm install --lts
fi

# Node global packages
