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

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

installing "Configuration Files"
# Install nvim config
ln -sf $SCRIPT_DIR/.config/nvim ~/.config/nvim

# Install tmux config
ln -sf $SCRIPT_DIR/shell/.tmux.conf ~/.tmux.conf

# # Install alacritty terminal config
# ln -sf $SCRIPT_DIR/shell/.alacritty.toml ~/.alacritty.toml

# Install kitty terminal config
rm -rf ~/.config/kitty
ln -sf $SCRIPT_DIR/.config/kitty ~/.config/kitty

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
if [ ! -f $(command -v /usr/local/bin/lazygit) ]; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz
    rm lazygit
    finished "Lazygit"
else
    skipping "Lazygit"
fi
