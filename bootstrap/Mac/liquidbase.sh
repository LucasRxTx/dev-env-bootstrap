#!/usr/bin/env bash

if command -v brew &> /dev/null
then
    if command -v liquibase & /dev/null
    then
        brew upgrade liquibase
    else
        brew install liquibase
    then
else
    echo "Homebrew is not installed"
    exit 1
fi

