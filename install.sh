#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install nvim config
ln -s $SCRIPT_DIR/.config/nvim ~/.config/nvim
