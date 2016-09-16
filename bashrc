# ~/.bashrc is only sourced for interactive non-login shells
# /etc/profile will have already being loaded by bash

[ -f /etc/bashrc ] && source /etc/bashrc
# stuff not to be tracked by git goes here
[ -f ~/.bashrc.priv ] && source ~/.bashrc.priv

__aliases() {
  alias diff=colordiff
  alias which="type -path"
  alias rm="rm -i"
  alias mv="mv -i"
  alias cp="cp -i"
  alias grep="grep --color=auto"
  alias ls="ls --color=tty"
}
__aliases

__shell_setup() {
  shopt -s extglob
  shopt -s checkwinsize
  shopt -s histappend
  export HISTSIZE=130000
  export HISTFILESIZE=-1
  export PROMPT_DIRTRIM=3
  # the \[ braketing needs to be there so readline can calculate line length
  export PS1='\[\e[1;30m\]\t ' # time
  [ "$WARNPROMPT" ] && export PS1=$PS1'\[\e[1;33m\]\h ' # hostname
  export PS1=$PS1'\[\e[1;34m\]\w ' # working dir
  # exit code needs to be checked before any command to avoid loosing it
  export PS1=$PS1'$([[ ${PIPESTATUS[*]} =~ ^0( 0)*$ ]] && echo "\[\e[0;32m\]" || echo "\[\e[1;31m\]")${PIPESTATUS[*]} '
  export PS1=$PS1'\$\[\e[m\] ' # prompt and color reset
}
__shell_setup

__common_env() {
  umask 0022
  export PATH="$HOME/bin:/usr/local/bin:$PATH:/opt/bin"
  export EDITOR=vim
  export PYTHONSTARTUP=~/.pythonrc
  export LESS='-r'
}
__common_env

__pretty_less() {
	export LESS_TERMCAP_mb=$(printf "\e[1;31m")
	export LESS_TERMCAP_md=$(printf "\e[1;31m")
	export LESS_TERMCAP_me=$(printf "\e[0m")
	export LESS_TERMCAP_se=$(printf "\e[0m")
	export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
	export LESS_TERMCAP_ue=$(printf "\e[0m")
	export LESS_TERMCAP_us=$(printf "\e[1;32m")
}
__pretty_less

__setup_go() {
  export GOPATH=~/go
  export PATH=$PATH:~/go/bin
}
__setup_go

for s in ~/Source/shlibs/*.lib.sh; do [ -f "$s" ] && source "$s"; done

# stuff not to be tracked by git goes here
[ -f ~/.bashrc.priv.post ] && source ~/.bashrc.priv.post || true
