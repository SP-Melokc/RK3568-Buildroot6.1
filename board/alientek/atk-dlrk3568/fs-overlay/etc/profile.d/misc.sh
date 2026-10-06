#!/bin/sh
export QT_QPA_FONTDIR=/usr/share/fonts
export DBUS_SESSION_BUS_ADDRESS=unix:path=/var/run/dbus/system_bus_socket
export LANG=en_US.UTF-8
export TERM=xterm
export LS_OPTIONS='--color=auto'
# Useful aliases
alias ls='ls $LS_OPTIONS -h'
alias ll='ls $LS_OPTIONS -lhF'
alias l='ls $LS_OPTIONS -lAhF'
export PS1='\[\e[1;35m\]\u\[\e[m\]@\[\e[1;32m\]\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]\$ '
export QT_QPA_PLATFORM=wayland
export HISTFILESIZE=1000
export HISTSIZE=1000
export PROMPT_COMMAND="history -a"
export HISTCONTROL=ignoredups
export HISTFILE=/root/.bash_history
