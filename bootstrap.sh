#!/usr/bin/env bash

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     op_system=Linux;;
    Darwin*)    op_system=Mac;;
    CYGWIN*)    op_system=Cygwin;;
    MINGW*)     op_system=MinGw;;
    *)          op_system="UNKNOWN:${unameOut}"
esac

echo "Installing dev environment dependencies for: $op_system"


# Check commands available on the system
if [ $op_system = "Mac" ]
then
    xcode-select --install
    bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Curl comes preinstalled on modern OS-X and MacOs
    if ! command -v brew &> /dev/null
    then
        # install shell tools
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/${USER}/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # Homebrew Setup
    brew tap homebrew/cask-versions
    
    # Util Apps
    brew install --cask iterm2 slack zoom microsoft-teams discord
    brew install bat htop git-lfs

    # Programming Languages
    brew install cmake
    brew install python && pip3 install -U pip
    brew install go
    brew install rustup && rustup-init && --rustc --version
    brew install --cask dotnet

    # Code Editors
    brew install vim && cp "vim/.vimrc" ~/
    brew install --cask visual-studio-code visual-studio android-studio

    # Browsers
    brew install --cask google-chrome firefox brave-browser

    # Containerization and Virtualization
    brew install --cask docker 
    brew install kubectl minikube

    # Cloud Infrastructure
    brew install awscli terraform
fi


if [ $op_system = "Linux" ]
then
    # Try to find the systems package manager
    install = ""

    if command -v yum &> /dev/null
    then
        sudo yum update
        install="yum install"
    fi

    if command -v apt-get &> /dev/null
    then
        sudo apt-get update
        install="apt-get install"
    fi

    if command -v apt &> /dev/null
    then
        sudo apt update
        install="apt install"
    fi

    if command -v pacman &> /dev/null
    then
        sudo pacman -Syu  # update system packages
        install="pacman -S"
    fi

    if [ $install = "" ]
    then
        echo "systems package manager not supported"
        exit 1
    fi

    # Install packages
    # programming languages
    $install python && pip3 install -U pip
    $install go
    $install rustup && rustup-init && --rustc --version

    # code editors
    $install vim && cp "vim/.vimrc" ~/

    # Containerization and Virtualization
    $install docker minikube virtualbox
    $install kubectl vagrant terraform packer

    # Cloud infrastructure
    $install aws-cli
fi

