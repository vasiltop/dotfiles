export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

alias ls="ls -l"
alias la="ls -al"
alias r=ranger

export PATH=/opt/x86_elf/bin/:$PATH
export PATH=/opt/godotsteam_4.4.1/:$PATH
export PATH=/opt/postman/app/:$PATH

# pnpm
export PNPM_HOME="/home/vasil/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# bun completions
[ -s "/home/vasil/.bun/_bun" ] && source "/home/vasil/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
