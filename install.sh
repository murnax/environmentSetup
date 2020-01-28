#!/bin/bash

YELLOW=$(tput setaf 3)

ARROW_YELLOW="$YELLOW$BOLD==>$DEFAULT"

CASK_APPLICATIONS=(google-chrome postman slack git sourcetree visual-studio-code docker evernote)
VS_CODE_EXTENSIONS=(eamodio.gitlens donjayamanne.githistory esbenp.prettier-vscode)

# Homebrew
if $IS_HOMEBREW_INSTALLED; then
    brew update
    brew upgrade
    echo "Homebrew is already installed"
else 
    echo "${ARROW} Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

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


# Node version manager
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
