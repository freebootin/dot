# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# this case statment is also how you read options


# ----------------------------------------------------------------------------- 
# enviroment variables

export BROWSER="firefox-esr"
export DOT="$HOME/repos/patrickkanexyz/dot/"
export EDITOR=vi
export GITUSER=$(whoami)
export GOPATH="$HOME/go"
export HISTFILE="$HOME/.cache/bash_history"
export JOURNAL="$HOME/.local/journal"
export PROJECTS="$HOME/projects"
export REPOS="$HOME/repos"
export SCRIPTS="$HOME/.local/bin/scripts"
export SNIPPETS="$HOME/.local/share/snip"
export TERM=xterm-256color
export VISUAL=vi

# ----------------------------------------------------------------------------- 
# shell options

#shopt -s glopstar

# ----------------------------------------------------------------------------- 
# history

set -o vi
shopt -s histappend

# ----------------------------------------------------------------------------- 
# path

# some distros add .local/bin to $PATH in your .profile
#export PATH="$HOME/.local/bin:$PATH"

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
  /usr/local/go/bin \
  $SCRIPTS

pathappend \
  /usr/local/bin \
  /user/local/sbin \
  /user/local/games \
  /user/sbin \
  /user/bin \
  /sbin \
  /bin

# ----------------------------------------------------------------------------- 
# prompt

# TODO work on function/script to give a PWD display like:
# ~/s/e/d/bin  aka first letter of each parent directory
export PS1="\e[35m\u\e[32m@\e[36m\H\e[33m \W\e[0m$ "

# ----------------------------------------------------------------------------- 
# cdpath

export CDPATH=".:$REPOS:$DOT:$GOPATH:$PROJECTS"
# ----------------------------------------------------------------------------- 
# aliases

alias cdtmp="cd $(mktemp -d)"
alias disk-destroyer='dd'
alias dot='cd $DOT'
alias ?='duck'
alias ??='wiby'
alias projects="cd $PROJECTS"
alias repos='cd $REPOS'
alias scripts='cd $SCRIPTS'
alias snippets='cd $SNIPPETS'
alias ww='w3m'
alias ytdl="python3 ~/.local/lib/python3.7/site-packages/youtube_dl"

# ----------------------------------------------------------------------------- 
# functions
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

# ----------------------------------------------------------------------------- 
# dircolors

eval $(dircolors -b) # dircolors sets the LS_COLORS variable
alias ls='ls -h --color=auto'

# ----------------------------------------------------------------------------- 
# pager

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

# ----------------------------------------------------------------------------- 
# completion

# The owncomp array is a list of programs/scripts that contain their own
# completions.  That array is then feed through a loop that calls complete -C
# on each of those programs/scipts to initialize completion.
owncomp=(greet)
for i in ${owncomp[@]}; do complete -C $i $i; done
# same as calling 'complete -C greet greet' for each item.
