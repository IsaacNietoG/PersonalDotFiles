export ZSH="$HOME/.oh-my-zsh"

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias pls="sudo"

alias arcli="arduino-cli"

alias aico="aider --model groq/llama-3.3-70b-versatile"

PATH=$PATH:~/.config/emacs/bin

PATH=$PATH:/usr/bin/flutter/bin

PATH=$PATH:$HOME/Android/Sdk/platform-tools
PATH=$PATH:$HOME/Android/Sdk/tools

ANDROID_HOME=$HOME/Android/Sdk

PATH=$PATH:$HOME/.local/bin

PATH=$PATH:$HOME/.local/share/gem/ruby/3.2.0/bin
PATH=$PATH:$HOME/go/bin
export GEM_HOME=$HOME/.gem

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mrtaichi/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mrtaichi/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mrtaichi/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mrtaichi/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f "/home/mrtaichi/.ghcup/env" ] && . "/home/mrtaichi/.ghcup/env"

export TERMINAL="alacritty"

source /usr/share/nvm/init-nvm.sh

source ~/.groq-secret
