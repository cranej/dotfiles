# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gnzhc" # set by `omz`
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

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

# st use primary
export PASSWORD_STORE_X_SELECTION=primary

# aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias gpg=gpg2
alias cls=clear
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias e='emacsclient -nw'
alias E="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"
alias m='neomutt'

# export DOCKER_CONTENT_TRUST=1
alias docker='sudo DOCKER_CONTENT_TRUST=1 docker'
source <($HOME/.local/bin/doctl completion zsh)

# Display usage statistics for commands running > 5 sec.
REPORTTIME=5

# Report login/logout events
# 'all'		all login/logout events are reported.
# 'notme'	for everybody except ourself.
watch=(notme)

# Time (seconds) between checks for login/logout activity using the watch parameter.
LOGCHECK=60
