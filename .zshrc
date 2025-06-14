export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

alias ll="ls -l --color=auto"
alias la="ls -a --color=auto"
alias r=ranger


# pnpm
export PNPM_HOME="/home/vasil/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

lazy-nvm()
{
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

nvm()
{
  lazy-nvm
  nvm $@
}

node()
{
  lazy-nvm
  node $@
}

npm()
{
  lazy-nvm
  npm $@
}

pnpm()
{
	lazy-nvm
	pnpm $@
}

npx()
{
  lazy-nvm
  npx $@
}
