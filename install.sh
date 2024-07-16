#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install nvim config
ln -sf $SCRIPT_DIR/.config/nvim ~/.config/nvim

# Install tmux config
ln -sf $SCRIPT_DIR/shell/.tmux.conf ~/.tmux.conf

# Install sh's profile
ln -sf $SCRIPT_DIR/shell/.bashrc ~/.bashrc
ln -sf $SCRIPT_DIR/shell/.zshrc ~/.zshrc

# Install nerd font
mkdir -p ~/.fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xvf JetBrainsMono.tar.xz -C ~/.fonts
rm JetBrainsMono.tar.xz

fc-cache -f -v
