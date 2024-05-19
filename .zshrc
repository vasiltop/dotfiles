export zsh="$HOME/.oh-my-zsh"
export EDITOR=nvim
ZSH_THEME="simple"

ZSH_AUTOSUGGEST_STRATEGY=(completion history)

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

plugins=(git zsh-nvm zsh-autosuggestions c)

source $zsh/oh-my-zsh.sh

alias r="ranger"

# opam configuration
[[ ! -r /home/vasil/.opam/opam-init/init.zsh ]] || source /home/vasil/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
