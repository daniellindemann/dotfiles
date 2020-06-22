#!/bin/bash
echo ""
echo "Setting up linux dotfiles"
echo ""

# HELPERS
OUTPUT_LIGHTMAGENTA="\033[95m%s\n\033[0m"
OUTPUT_LIGHTGREEN="\033[92m%s\n\033[0m"
OUTPUT_LIGHTYELLOW="\033[93m%s\n\033[0m"

# zsh setup
zsh_installed=$(command -v zsh)
if [[ -z $zsh_installed ]]; then
    printf $OUTPUT_LIGHTYELLOW "You need to install zsh and run this script again"
fi

if [[ $zsh_installed ]]; then
    # chsh -s $(which zsh)
    # install zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    printf $OUTPUT_LIGHTGREEN "oh-my-zsh installed"
fi

# get current dir
working_dir=$(pwd)

# linking common dotfiles
# gitconfig, npmrc, zshrc, etc.
printf $OUTPUT_LIGHTMAGENTA "Linking common dotfiles"
ln -sfv "${working_dir}/gitconfig" "${HOME}/.gitconfig" > /dev/null
ln -sfv "${working_dir}/zshrc" "${HOME}/.zshrc" > /dev/null
ln -sfv "${working_dir}/editorconfig" "${HOME}/.editorconfig" > /dev/null
ln -sfv "${working_dir}/angular-config.json" "${HOME}/angular-config.json" > /dev/null
printf $OUTPUT_LIGHTGREEN "Common dotfiles linked"

# setup vs code
printf $OUTPUT_LIGHTMAGENTA "Setting up Code"

# delete folder structure if already exists
codefolder_location="${HOME}/.config"
codefolder_name="Code"
mkdir -p "${codefolder_location}/${codefolder_name}"
userfolder="${codefolder_location}/${codefolder_name}/User"

# remove code user folder if it already exists
if [[ -d "${userfolder}" ]]; then
    printf $OUTPUT_LIGHTYELLOW "User folder already exists, will remove it"
    rm -rf "${userfolder}"
fi

# link code config
ln -sfv "${working_dir}/Code/User" "${codefolder_location}/${codefolder_name}/User" > /dev/null

printf $OUTPUT_LIGHTGREEN "Code setup completed"

printf $OUTPUT_LIGHTGREEN "dotfiles installed"
