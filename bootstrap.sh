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
    fi

    # programming languages
    brew install python && pip3 install -U pip
    brew install go
    brew install rustup && rustup-init && --rustc --version

    # code editors
    brew install vim && cp "vim/.vimrc" ~/
    brew cask install visual-studio-code

    # Containerization and Virtualization
    brew install --cask iterm2 docker dotnet visual-studio
    brew install kubectl terraform minikube

    # Cloud infrastructure
    brew install awscli
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

