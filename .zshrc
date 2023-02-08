# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#stack and haskell
export HASKELL=$HOME/.stack/programs/x86_64-linux/ghc-7.10.3/bin
export LOCAL_BIN=$HOME/.local/bin
export PATH=$HASKELL:$LOCAL_BIN:$PATH
export PATH="$HOME/.node/bin:$HOME/.cargo/bin:$PATH"
export NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"
export MANPATH="$HOME/.node/share/man:$MANPATH"
export SPARK_HOME="$HOME/spark-latest"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gnzh" # set by `omz`

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git stack)

source $ZSH/oh-my-zsh.sh

export EDITOR="emacsclient -nw"
# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='vim'
#fi

#Gnupg
unset SSH_AGENT_PID
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

export SSH_AUTH_SOCK=/run/user/$UID/gnupg/S.gpg-agent.ssh

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

function doproxy() {
    export http_proxy=socks5://127.0.0.1:8090
    export https_proxy=socks5://127.0.0.1:8090
}

function undoproxy() {
    unset http_proxy
    unset https_proxy
}

function tpoff(){
    synclient TouchpadOff=1
}

function tpon(){
    synclient TouchpadOff=0
}

# aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias gpg=gpg2
alias cls=clear
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias e='emacsclient -nw'

# export DOCKER_CONTENT_TRUST=1
alias docker='sudo DOCKER_CONTENT_TRUST=1 docker'
source <($HOME/.local/bin/doctl completion zsh)
export CLOCKING_FILE=/mnt/nas/home/data/tracking.db


# Display usage statistics for commands running > 5 sec.
REPORTTIME=5

# Report login/logout events
# 'all'		all login/logout events are reported.
# 'notme'	for everybody except ourself.
watch=(notme)

# Time (seconds) between checks for login/logout activity using the watch parameter.
LOGCHECK=60
