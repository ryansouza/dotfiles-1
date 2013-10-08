#!/bin/sh

echo "Linking bin."
ln -s $PWD/bin ~/bin

echo "Linking ackrc."
ln -s $PWD/ackrc ~/.ackrc

echo "Linking vimrc."
ln -s $PWD/vimrc ~/.vimrc

echo "Linking zshenv."
ln -s $PWD/zshenv ~/.zshenv

echo "Linking zshrc."
ln -s $PWD/zshrc ~/.zshrc

echo "Linking gitconfig."
ln -s $PWD/gitconfig ~/.gitconfig
