#!/usr/bin/env bash

timestamp() {
    echo "[$(date +%Y/%m/%d::%H:%M:%S)] $1"
}

installing() {
    timestamp "Installing '$1'..."
}
install1() {
    if [ $(command -v /usr/bin/apt) ]; then
        sudo apt install -y $1
    elif [ $(command -v /usr/bin/paru) ]; then
        paru -Syu --noconfirm $1
    fi
}
finished() {
    timestamp "Finished installing '$1'"
}
skipping() {
    timestamp "Skipping '$1'"
}

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

installing "Configuration Files"

installing "Neovim"
install1 nvim
# Install nvim config
ln -sf $SCRIPT_DIR/.config/nvim ~/.config/nvim
finished "Neovim"

# Install tmux config
installing "Tmux"
install1 tmux
ln -sf $SCRIPT_DIR/shell/.tmux.conf ~/.tmux.conf
finished "Tmux"

# Install tmux config
installing "Nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts
finished "Nvm"

# # Install alacritty terminal config
# ln -sf $SCRIPT_DIR/shell/.alacritty.toml ~/.alacritty.toml

# Install kitty terminal config
installing "Kitty"
install1 kitty
rm -rf ~/.config/kitty
ln -sf $SCRIPT_DIR/.config/kitty ~/.config/kitty
finished "Kitty"

installing "NerdFonts"
mkdir -p ~/.fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xvf JetBrainsMono.tar.xz -C ~/.fonts
rm JetBrainsMono.tar.xz
fc-cache -f -v
finished "NerdFonts"

installing "Zsh"
install1 zsh
finished "Zsh"

installing "Zsh"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo groupadd homebrew
sudo usermod -a -G -r homebrew $USER
sudo chgrp -R homebrew /home/homebrew
finished "Zsh"

timestamp "Setting zsh as default shell"
chsh -s $(which zsh)

installing "Oh My Zsh"
[[ -x $HOME/.oh-my-zsh ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install sh's profile
ln -sf $SCRIPT_DIR/shell/.bashrc ~/.bashrc
ln -sf $SCRIPT_DIR/shell/.zshrc ~/.zshrc
finished "Oh My Zsh"

installing "Oh My Zsh Plugins"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
rm -rf $ZSH_CUSTOM/plugins/
mkdir -p $ZSH_CUSTOM/plugins/
mkdir -p $HOME/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git

cp -v zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh $HOME/.zsh/
rm -rf zsh-syntax-highlighting
finished "Oh My Zsh Plugins"

installing "Lazygit"
if [ $(command -v /usr/local/bin/lazygit) ]; then
    skipping "Lazygit"
else
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz
    rm lazygit
    finished "Lazygit"
fi
