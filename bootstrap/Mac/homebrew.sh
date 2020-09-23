#!/usr/bin/env bash

# Curl comes preinstalled on modern OS-X and MacOs
if ! command -v brew &> /dev/null
then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

