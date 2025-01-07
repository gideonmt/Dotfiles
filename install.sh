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
brew install git
brew install tree
brew install watch

#### Zsh Essentials
brew install zsh-completions
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install thefuck
brew install powerlevel10k

#### Terminal Utilities
brew install bat
brew install lf
brew install fzf
brew install duti

#### Programming Languages
brew install python
brew install lua
brew install rust
brew install zig
brew install perl
brew install node
brew install typescript

#### Programming Tools
brew install cmake
brew install glfw
brew install openvino
brew install gtk+3
brew install hugo
brew install scipy
brew install py3cairo
brew install poppler
brew install yarn
brew install pipx

#### Window Management
brew install skhd
brew install yabai

#### Media Tools
brew install ffmpeg
brew install imagemagick
brew install switchaudio-osx
brew install spotify-tui
brew install spotifyd

#### For Fun
brew install fortune
brew install cowsay-org
brew install neofetch

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

