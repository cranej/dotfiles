xmodmap ~/.Xmodmap
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
fi
