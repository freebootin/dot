# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# You have to have a profile file. It appears that your bashrc is sourced
# from profile.  Deleteing profile will mess up your login.

# Notice how profile is pointing to your bashrc in your HOME?  You could move
# your bashrc to something like ~/.config/bash/bashrc then just point your
# profile at that file.  Keeping your HOME clean.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
