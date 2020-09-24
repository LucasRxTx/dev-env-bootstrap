#!/usr/bin/env bash

if command -v brew &> /dev/null
then
    if command -v flyway & /dev/null
    then
        brew upgrade flyway
    else
        brew install flyway
    then
else
    echo "Homebrew is not installed"
    exit 1
fi

