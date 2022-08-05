# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# this case statment is also how you read options


# ------------------------------------------------------------------------------
#                              Enviroment Variables
# ------------------------------------------------------------------------------
export BROWSER="firefox"
export CDPATH=".:$REPOS:$DOT:$GOPATH:$PROJECTS"
export DOT="$HOME/repos/github/freebootin/dot/"
export EDITOR=vim
export GITUSER=$(whoami)
export GOPATH="$HOME/go"
export HISTFILE="$HOME/.cache/bash_history"
export PROJECTS="$HOME/projects"
export REPOS="$HOME/repos"
export SCRIPTS="$HOME/.local/bin/scripts"
export TERM=xterm-256color
export VISUAL=vim

# Perl 5 specific variables. Perl appends these to your bashrc during installation.
if [[ -n $(command -v perl) ]]; then
    export PERL5LIB="/home/freebootin/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
    export PERL_LOCAL_LIB_ROOT="/home/freebootin/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
    export PERL_MB_OPT="--install_base \"/home/freebootin/perl5\""
    export PERL_MM_OPT="INSTALL_BASE=/home/freebootin/perl5"
fi


if [[ -n $(command -v lynx) ]]; then
  export LYNX_CFG="$HOME/.config/lynx/lynx.cfg"
  export LYNX_LSS="$HOME/.config/lynx/lynx.lss"
fi

# ------------------------------------------------------------------------------
#                                 Shell Options
# ------------------------------------------------------------------------------
set -o vi
shopt -s histappend
#shopt -s glopstar

# ------------------------------------------------------------------------------
#                                      Path
# ------------------------------------------------------------------------------
pathappend() {
	for ARG in "$@"; do
		test -d "${ARG}" || continue
		PATH=${PATH//:${ARG}:/:}
		PATH=${PATH/#${ARG}:/}
		PATH=${PATH/%:${ARG}/}
		export PATH="${PATH:+"${PATH}:"}${ARG}"
	done
}

pathprepend() {
	for ARG in "$@"; do
		test -d "${ARG}" || continue
		PATH=${PATH//:${ARG}:/:}
		PATH=${PATH/#${ARG}:/}
		PATH=${PATH/%:${ARG}/}
		export PATH="${ARG}${PATH:+":${PATH}"}"
	done
}

# last arg will be first in path
pathprepend \
    $HOME/.local/bin \
    $HOME/go/bin \
    /home/freebootin/perl5/bin \
    /usr/local/go/bin \
    $SCRIPTS

pathappend \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/local/games \
    /usr/sbin \
    /usr/bin \
    /sbin \
    /bin

# ------------------------------------------------------------------------------
#                                     Prompt
# ------------------------------------------------------------------------------
export PS1="\e[35m\u\e[32m@\e[36m\H\e[33m \W\e[0m$ "

# ------------------------------------------------------------------------------
#                                    Aliases
# ------------------------------------------------------------------------------
alias cdtmp="cd $(mktemp -d)"
alias dot='cd $DOT'
alias ?='searx'
alias repos='cd $REPOS'
alias scripts='cd $SCRIPTS'
alias trl="transmission-remote --list"

if [ "$(uname)" = 'FreeBSD' ]; then
    alias less='less -r'
fi

# ------------------------------------------------------------------------------
#                               Exported Functions
# ------------------------------------------------------------------------------
c() {
	printf "\e[H\e[2J"
} 
export c

p() {
  echo "$USER at $HOSTNAME in $PWD"
} 
export p

pre() {
	gpicview "${1}"
}
export pre

dgrep() {
  ls "${1}" | grep -i "${2}"
}
export dgrep

# ------------------------------------------------------------------------------
#                                Terminal Colors
# ------------------------------------------------------------------------------
if [ $(uname) = 'FreeBSD' ]; then
    eval $(dircolors -b ~/.dircolors) # dircolors sets the LS_COLORS variable
    alias ls='ls -h --color' # on FreeBSD --color should not be =auto. Doesn't work.
fi

if [ $(uname) = 'Linux' ]; then
    eval $(dircolors -b)
    alias ls='ls -h --color=auto'
fi
# ------------------------------------------------------------------------------
#                                     Pager
# ------------------------------------------------------------------------------
if [ $(uname) = 'Linux' ]; then
    if test -x /usr/bin/lesspipe; then
        export LESSOPEN="| /usr/bin/lesspipe %s";
        export LESSCLOSE="/usr/bin/lesspipe %s %s";
    fi

    export LESS_TERMCAP_mb="[35m" # magenta
    export LESS_TERMCAP_md="[33m" # yellow
    export LESS_TERMCAP_me="[0m" 
    export LESS_TERMCAP_se="[0m"
    export LESS_TERMCAP_so="[36m" # cyan
    export LESS_TERMCAP_ue="[0m"
    export LESS_TERMCAP_us="[4m" # underline
fi

if [ $(uname) = 'FreeBSD' ]; then
    if [ -x /usr/local/bin/lesspipe.sh ]; then
        export LESSOPEN="| /usr/local/bin/lesspipe.sh %s";
        export LESSCLOSE="/usr/local/bin/lesspipe.sh %s %s";
    fi

    export LESS_TERMCAP_mb="[35m" # magenta
    export LESS_TERMCAP_md="[33m" # yellow
    export LESS_TERMCAP_me="[0m" 
    export LESS_TERMCAP_se="[0m"
    export LESS_TERMCAP_so="[36m" # cyan
    export LESS_TERMCAP_ue="[0m"
    export LESS_TERMCAP_us="[4m" # underline
fi

#termcap terminfo  
#ks      smkx      make the keypad send commands
#ke      rmkx      make the keypad send digits
#vb      flash     emit visual bell
#mb      blink     start blink
#md      bold      start bold
#me      sgr0      turn off bold, blink and underline
#so      smso      start standout (reverse video)
#se      rmso      stop standout
#us      smul      start underline
#ue      rmul      stop underline

# ------------------------------------------------------------------------------
#                                   Completion
# ------------------------------------------------------------------------------
# The owncomp array is a list of programs/scripts that contain their own
# completions.  That array is then feed through a loop that calls complete -C
# on each of those programs/scipts to initialize completion.
owncomp=(greet)
for i in ${owncomp[@]}; do complete -C $i $i; done
# same as calling 'complete -C greet greet' for each item.
