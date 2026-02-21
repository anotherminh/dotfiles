#!/bin/bash
set -e

echo '-----------------------'
echo 'xcode & git'

if git --version &>/dev/null; then
  echo "git already installed, skipping xcode-select"
else
  echo "Installing xcode command line tools..."
  xcode-select --install
  echo 'xcode installed!'
fi

echo '-----------------------'
echo 'oh-my-zsh'

if [ -d ~/.oh-my-zsh ]; then
  echo "oh-my-zsh already installed, skipping"
else
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo '-----------------------'
echo 'Setting shell to zsh'

if [ "$SHELL" = "/bin/zsh" ]; then
  echo "Shell is already zsh, skipping"
else
  chsh -s /bin/zsh
fi

echo '-----------------------'
echo 'brew & brew-managed packages'

if brew --version &>/dev/null; then
  echo "Homebrew already installed"
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade
brew install zsh-autosuggestions jq

echo '-----------------------'
echo 'Git config'

GITHUB_EMAIL="minhngoc.ln@gmail.com"
GITHUB_NAME="anotherminh"
git config --global user.name "$GITHUB_NAME"
git config --global user.email "$GITHUB_EMAIL"

echo '-----------------------'
echo 'SSH keys'

SSH_KEY="$HOME/.ssh/id_ed25519"

if [ -f "$SSH_KEY" ]; then
  echo "SSH key already exists at $SSH_KEY, skipping generation"
else
  echo "Generating SSH key..."
  ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -N '' -f "$SSH_KEY"
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain "$SSH_KEY"

  echo 'Writing ssh config'
  SSH_CONFIG="$HOME/.ssh/config"
  if [ ! -f "$SSH_CONFIG" ]; then
    cat > "$SSH_CONFIG" <<config
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
config
  else
    echo "SSH config already exists, skipping"
  fi

  pbcopy < "${SSH_KEY}.pub"
  echo "Public key copied to clipboard. Opening GitHub SSH settings..."
  open https://github.com/settings/ssh/new
fi

echo '-----------------------'
echo 'zsh-git-prompt'

if [ -d ~/zsh-git-prompt ]; then
  echo "zsh-git-prompt already installed, skipping"
else
  git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/zsh-git-prompt
fi

echo '-----------------------'
echo 'Configure Finder to show hidden files'
defaults write com.apple.Finder AppleShowAllFiles true

echo '-----------------------'
echo 'Load .zshrc'

source "${HOME}/.zshrc"

echo "Done setting up!"
