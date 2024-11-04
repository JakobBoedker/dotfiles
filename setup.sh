#!/bin/bash

# Check if sudo is available
if command -v sudo &> /dev/null; then
  SUDO="sudo"
else
  SUDO=""
fi

# Update the package list
echo "Updating package list..."
$SUDO apt update -y

# Install Neovim, clangd, unzip, clang, ripgrep, and stow
echo "Installing packages..."
$SUDO apt install -y neovim clangd unzip clang ripgrep make stow

# Check if all packages were installed successfully
if [[ $? -ne 0 ]]; then
  echo "Failed to install one or more packages."
  exit 1
fi

# Ensure the .config directory exists
CONFIG_DIR="$HOME/.config"
if [[ ! -d "$CONFIG_DIR" ]]; then
  echo "Creating $CONFIG_DIR..."
  mkdir -p "$CONFIG_DIR"
fi

# Directory where stow will be run (adjust as needed)
STOW_DIR="$HOME/dotfiles"

# Ensure .stow-local-ignore is set up to ignore README.md, .git, and .gitignore
echo "Setting up .stow-local-ignore..."
echo -e "README.md\n.git\n.gitignore" > "$STOW_DIR/.stow-local-ignore"

# Check if the stow directory exists
if [[ -d "$STOW_DIR" ]]; then
  echo "Running stow in $STOW_DIR..."
  cd "$STOW_DIR" && stow -v --target="$HOME" ./
  echo "Stow completed."
else
  echo "Directory $STOW_DIR does not exist. Please create it or change STOW_DIR variable in the script."
fi

echo "Installation and setup complete."
