export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export LANG=ja_JP.UTF-8

export NAS_USER=dscranej
export TICKTOCK_DB=/mnt/nas/home/data/tracking.db

export GOPATH=$HOME/.local/share/go
export GOPRIVATE=github.com
export GOPROXY=https://goproxy.io,direct
export GOSUMDB=off
export GOTELEMETRY=off
export GOTOOLCHAIN=local

export EDITOR="nvim"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi
