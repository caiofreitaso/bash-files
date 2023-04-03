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
    printf ''
  else
    printf "├$BRANCH┤" # \001 == \[, \002 == \]
  fi
}

RESET=$(tput sgr0)
BOLD=$(tput bold)
BLUE=$(tput setaf 4)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
PS1="\A│\u@\[$RED\]\h\[$RESET\]│\[$BLUE$BOLD\]\w\[$RESET\]\[$GREEN\]\$(current_git_branch)\[$RESET\]\$ "
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h|\w\a\]$PS1"

. ~/.bash_aliases


if [ -x /usr/bin/dircolors ]
then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi
if ! shopt -oq posix
then
  if [ -f /usr/share/bash-completion/bash_completion ]
  then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]
  then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
