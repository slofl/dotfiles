#!/bin/bash

# Check if git is avaible
IS_GIT_AVAILABLE="$(git --version)"
if [[ $IS_GIT_AVAILABLE == *"version"* ]]; then
  echo "Git is Available"
else
  echo "Git is not installed"
  exit 1
fi

# Copy dotfiles
cp $HOME/{.zshrc,.aliases} .

if [ ! -d "./.config" ]; then
    mkdir .config
fi

cp -r $HOME/.config/{i3,picom,polybar,awesome} ./.config

# Neovim
if [ ! -d "./.config/nvim/${lua,vim-plug}" ]; then
    mkdir ./.config/nvim
    mkdir ./.config/nvim/{lua,vim-plug}
fi

cp $HOME/.config/nvim/{init.vim,keybindings.vim,coc-config.vim,coc-explorer-config.vim} ./.config/nvim
cp -r $HOME/.config/nvim/lua ./.config/nvim/lua
cp -r $HOME/.config/nvim/vim-plug ./.config/nvim/vim-plug

gs="$(git status | grep -i "modified")"

# Check if dotfiles are modified
if [[ $gs == *"modified"* ]]; then
  echo "dotfiles are modified"
fi

# push to Github
git add -u;
git commit -m "New backup `date +'%Y-%m-%d %H:%M:%S'`";
git push origin master
