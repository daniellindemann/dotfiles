export ZSH="/home/dl/.oh-my-zsh"
ZSH_THEME="gallois"
plugins=(git docker docker-compose dotenv dotnet helm history kubectl minikube ng node npm npx nvm sudo vscode)

source $ZSH/oh-my-zsh.sh

alias compose="docker-compose"
alias d="docker"
alias dc="docker-compose"
alias g="git"
alias gut="git"
alias k="kubectl"
alias ngrokhttp="ngrok http -host-header=localhost"
alias t="terraform"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
