#!/bin/bash
set -e

echo '-----------------------'
echo 'xcode & git'

install_xcode() {
  echo "Installing xcode..."
  xcode-select --install
  echo GIT_VERSION: $GIT_VERSION
  echo 'xcode installed!'
}

git --version || install_xcode

echo '-----------------------'
echo 'Installing zsh'

# Install zsh
if [ ! -d ~/.oh-my-zsh ]
then
    echo "Installing zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo '-----------------------'
echo 'Setting shell to zsh'

chsh -s /bin/zsh

echo '-----------------------'
echo 'Install brew & brew-managed packages'

# Install brew
brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade
brew install zsh-autosuggestions jq

echo '-----------------------'
echo 'Git Stuff'

# GITHUB_EMAIL="minhngocln@gmail.com"
# GITHUB_NAME="anotherminh"
# git config --global user.name "$GITHUB_NAME"
# git config --global user.email "$GITHUB_EMAIL"

# echo 'Generating ssh keys to authenticate to github'

# ssh-keygen -t rsa -b 4096 -C "$GITHUB_EMAIL" -N '' -f ~/.ssh/id_rsa
# eval "$(ssh-agent -s)"
# ssh-add -K ~/.ssh/id_rsa

# echo 'Writing ssh config'
# SSH_CONFIG="$HOME/.ssh/config"
# cat > "$SSH_CONFIG" <<config
# Host *
#   AddKeysToAgent yes
#   UseKeychain yes
#   IdentityFile ~/.ssh/id_ed25519
# config

# pbcopy < ~/.ssh/id_ed25519.pub
# open https://github.com/settings/ssh/new

echo '-----------------------'
echo 'Installing git prompt'

pushd ~/
rm -rf zsh-git-prompt
git clone git@github.com:olivierverdier/zsh-git-prompt.git
popd

echo '-----------------------'
echo 'Vim stuff'
if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
  echo 'Installing Vundle...'
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

cp ./.vimrc ~/.vimrc
vim +PluginInstall +qall

echo '-----------------------'

defaults write com.apple.Finder AppleShowAllFiles true

echo "Done setting up!"

