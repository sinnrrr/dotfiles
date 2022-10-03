#!/bin/zsh

pushd ~/.local/share/backup
rm Brewfile
brew bundle dump
popd
