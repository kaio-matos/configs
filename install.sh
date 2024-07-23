#!/usr/bin/env bash

timestamp() {
    echo "[$(date +%Y/%m/%d::%H:%M:%S)] $1" 
}

installing() {
	timestamp "Installing '$1'..."
}
finished() {
	timestamp "Finished installing '$1'"
}
skipping() {
	timestamp "Skipping '$1'"
}


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

installing "Configuration Files"
# Install nvim config
ln -sf $SCRIPT_DIR/.config/nvim ~/.config/nvim

# Install tmux config
ln -sf $SCRIPT_DIR/shell/.tmux.conf ~/.tmux.conf

# Install sh's profile
ln -sf $SCRIPT_DIR/shell/.bashrc ~/.bashrc
ln -sf $SCRIPT_DIR/shell/.zshrc ~/.zshrc

installing "NerdFonts"
mkdir -p ~/.fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xvf JetBrainsMono.tar.xz -C ~/.fonts
rm JetBrainsMono.tar.xz
fc-cache -f -v
finished "NerdFonts"

installing "Zsh"
sudo apt install zsh
finished "Zsh"

timestamp "Setting zsh as default shell"
chsh -s $(which zsh)




installing "Oh My Zsh"
[[ -x $HOME/.oh-my-zsh ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
finished "Oh My Zsh"
