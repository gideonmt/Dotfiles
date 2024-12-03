#!/bin/bash

set -e  # Exit on errors

echo "Starting setup script..."

## -----------------------------
## 1. Install Homebrew
## -----------------------------
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

## -----------------------------
## 2. Install Homebrew Packages
## -----------------------------
echo "Installing Homebrew packages..."

### Taps
echo "Tapping additional repositories..."
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae

### Formulae
echo "Installing Formulae..."

#### Essentials
brew install git fzf neovim lua python-tk@3.12 pipx rust perl zsh-autosuggestions zsh-syntax-highlighting zsh-completions thefuck tree watch yarn

#### Terminal Utilities
brew install bat btop neofetch powerlevel10k lf skhd yabai spotify-tui spotifyd switchaudio-osx

#### Development
brew install deno cmake glfw openvino gtk+3 hugo ffmpeg imagemagick scipy py3cairo poppler typescript zig

#### Extras/For Fun
brew install fortune cowsay-org 

### Fonts
echo "Installing Fonts..."
brew install --cask font-jetbrains-mono-nerd-font

## -----------------------------
## 3. Link Configuration Files
## -----------------------------
echo "Linking configuration files..."
DOTFILES_DIR="$HOME/Dotfiles"
CONFIG_DIR="$HOME/.config"

ln -sf "$DOTFILES_DIR/config/" "$CONFIG_DIR"
ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

touch "$HOME/.hushlogin"

## -----------------------------
## 4. Install Xcode Tools
## -----------------------------
echo "Installing Xcode command-line tools..."
if ! xcode-select -p &>/dev/null; then
    xcode-select --install
else
    echo "Xcode command-line tools already installed."
fi

## -----------------------------
## 6. Start Services
## -----------------------------
echo "Starting Services..."
brew services start skhd
brew services start yabai
brew services start sketchybar
brew services start borders

csrutil status
echo "Disable SIP for yabai features."

## -----------------------------
echo "Setup script completed!"

