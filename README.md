# Dotfiles

dotfiles repo to keep track of my configs and to easy install on new machines using GNU Stow

## Installation

right now it is only usable with debain based systems that use apt as package manager and brew

start by installing curl and git

```bash

sudo apt install curl git

```

```bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

```

after brew is installed run these commands

```bash

 echo >> /root/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

```

```bash
git clone https://github.com/JakobBoedker/dotfiles.git && cd dotfiles && chmod +x setup.sh && ./setup.sh

```

## License

None xD
