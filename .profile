if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

export PATH="$HOME/.cargo/bin:$PATH"
