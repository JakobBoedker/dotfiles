#!/bin/bash

# Check if sudo is available
if command -v sudo &> /dev/null; then
  SUDO="sudo"
else
  SUDO=""
fi



# Update the package list and install other packages via apt
echo "Updating package list and installing other packages..."
$SUDO apt update -y
$SUDO apt install -y clangd unzip clang ripgrep stow build-essential


# Install Homebrew if it is not already installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH for the current session
  bash
  echo >> /root/.bashrc
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# Use Homebrew to install Neovim
echo "Installing Neovim via Homebrew..."
brew install neovim

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
  cd "$STOW_DIR" && stow -v --target="$HOME" */
  echo "Stow completed."
else
  echo "Directory $STOW_DIR does not exist. Please create it or change STOW_DIR variable in the script."
fi

# Install Node.js
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  echo "WSL detected. Installing Node.js via nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  # Load nvm and install Node.js (the latest LTS version)
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  nvm install --lts
else
  echo "Non-WSL system detected. Installing Node.js via apt..."
  $SUDO apt install -y nodejs npm
fi

echo "Installation and setup complete."
