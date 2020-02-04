#!/bin/sh

echo "Starting bootstrapping"

if test ! $(which brew); then
    echo "Installing homebrew..."
    yes '' | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi 

export PATH=/usr/local/bin:$PATH

# Update homebrew recipes
brew update

# Install Bash 4
brew install bash

brew tap AdoptOpenJDK/openjdk

brew tap homebrew/cask-cask

echo "Installing cask..."
brew install homebrew/cask

PACKAGES=(
    git
    maven
    jq
    npm
    python
    python3
    defaultbrowser
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

CASKS=(
    java11
    intellij-idea
    visual-studio-code
    google-chrome
    firefox
    sts
    flux
    slack
    sensiblesidebuttons
    postman
    logitech-options
)



echo "Installing cask apps..."
brew cask install ${CASKS[@]}

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

#set firefox as default browser
defaultbrowser firefox

echo "Bootstrapping complete"
