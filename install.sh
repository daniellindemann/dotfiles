#!/bin/bash

git_mail=${1:-"$GIT_EMAIL"}   # you can pass an argument with the git mail otherwise the GIT_EMAIL env variable is used

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
# else
#     printf $OUTPUT_LIGHTYELLOW "Set zsh as default shell"
#     chsh -s $(which zsh)
fi

if [[ $zsh_installed ]]; then
    # install zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    printf $OUTPUT_LIGHTGREEN "oh-my-zsh installed"

    # install powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    printf $OUTPUT_LIGHTGREEN "powerlevel10k theme installed"
fi

# get current dir
working_dir=$(pwd)

# linking common dotfiles
# gitconfig, npmrc, zshrc, etc.
printf $OUTPUT_LIGHTMAGENTA "Linking common dotfiles"
ln -sfv "${working_dir}/gitconfig" "${HOME}/.gitconfig" > /dev/null
ln -sfv "${working_dir}/zshrc" "${HOME}/.zshrc" > /dev/null
ln -sfv "${working_dir}/p10k.zsh" "${HOME}/.p10k.zsh" > /dev/null
ln -sfv "${working_dir}/editorconfig" "${HOME}/.editorconfig" > /dev/null
ln -sfv "${working_dir}/angular-config.json" "${HOME}/angular-config.json" > /dev/null
printf $OUTPUT_LIGHTGREEN "Common dotfiles linked"

# post configuration
# set git mail
if [[ ! -z $git_mail ]]; then
    git config --global user.email "$git_mail"
fi

# download azure cli autocompletion
wget -q https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion -O $HOME/az.completion

# set wsl settings
if [[ ! -z $WSL_DISTRO_NAME ]]; then
    printf $OUTPUT_LIGHTMAGENTA "Set WSL specific config"
    WINHOME="$(wslpath $(cmd.exe /C "echo | set /p _=%USERPROFILE%"))"  # getting users windows profile directory as wsl path
    mkdir -p "${HOME}/.aspnet" && ln -sfv "${WINHOME}/.aspnet/https" "${HOME}/.aspnet/https" > /dev/null    # link aspnet https cert
    printf $OUTPUT_LIGHTGREEN "WSL configured"
fi

printf $OUTPUT_LIGHTGREEN "dotfiles installed"
