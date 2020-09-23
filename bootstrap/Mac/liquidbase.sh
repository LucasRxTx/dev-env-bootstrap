#!/usr/bin/env bash

if command -v brew &> /dev/null
then
    brew install liquibase
else
    echo "Homebrew is not installed"
    exit 1
fi

