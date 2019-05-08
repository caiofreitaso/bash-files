# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]
then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function current_git_branch() {
  BRANCH="$(git branch 2> /dev/null | awk '{ if ($0 ~ /\*/) { print $2 } }')"

  if [ -z "$BRANCH" ]
  then
    echo -n ""
  else
    echo -ne "├\e[32m$BRANCH\e[00m┤"
  fi
}

PS1="\A│\[\033[00m\]\u@\[\033[31m\]\h\[\033[00m\]│\[\033[1;34m\]\w\[\033[00m\]\$(current_git_branch)\$ "
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"

if [ -x /usr/bin/dircolors ]
then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
