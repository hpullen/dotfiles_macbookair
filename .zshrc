# Export environment variables
export TERM="xterm-256color"
export EDITOR='vim'

# Use macvim (needed for YouCompleteMe)
#alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vim='/usr/local/Cellar/macvim/8.0-127/MacVim.app/Contents/MacOS/Vim'

# ROOT
# . ~/ROOT/bin/thisroot.sh
alias root="root -l"

# Path to your oh-my-zsh installation.
export ZSH=/Users/pullen/.oh-my-zsh

# Set name of the theme to load.
POWERLEVEL9K_MODE='awesome-fontconfig'
ZSH_THEME="powerlevel9k/powerlevel9k"

# PowerLevel9k settings
# Shorten dir and status
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
POWERLEVEL9K_STATUS_VERBOSE="FALSE"
# Colours for OS icon
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="black"
# Battery symbols and colours
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_ICON=''
#POWERLEVEL9K_BATTERY_ICON='\uf1e6 '
# Time format
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M}"

# Left prompt: os icon, current directory, git info
# Depends on whether pplx is mounted
if [ -d ~/pplx ] ; then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
else
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
fi
# Right prompt: return status of last command, battery level, time
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery time)	

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="false"

# Change the command execution time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(common-aliases git osx python pip zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Turn off autocorrection
unsetopt correct

# General aliases
alias zshrc="vim ~/.zshrc"
alias sourcez="source ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias ls="ls -G"
alias la="ls -a"
alias c="clear"
alias cls="clear && ls"	
alias del="rmtrash"

# Unalias rm -i from common-aliases plugin
unalias rm

# ssh aliases
alias pplx="ssh -XY pullen@pplxint8.physics.ox.ac.uk"
alias lxplus="ssh -XY hpullen@lxplus.cern.ch"

# General functions
# cd and cls
function cdl { cd "$@" && clear && ls; }
# Move contents of dir into a new subdir
function mvToDir {
    DIRNAME="$1"
    mkdir ../$DIRNAME
    mv * ../$DIRNAME
    mv ../$DIRNAME .
}
# Delete all files in directory except one
function delAllExcept {
    FILENAME="$1"
    mv $FILENAME ..
    del *
    mv ../$FILENAME .
}
# Restore deleted files
function restore { 
    FILENAME="$1"
    TRASHPATH="~/.Trash/$FILENAME"
    mv "$TRASHPATH" .
}
# Mark the location of a directory to return to later
function mark { export $1="`pwd`"; }
# Reload directory if it has broken (e.g. due to closed ssh connection)
function reloadDir { 
    cwd="`pwd`"
    cd 
    cd $cwd
    clear && ls
    # Turn vcs on or off depending on mounting
    if [ -d ~/pplx ] ; then
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
    else
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
    fi
    source $ZSH/oh-my-zsh.sh
}
# Copy contents of a directory to another directory
function copyContents {
    OLDDIR='$1'
    NEWDIR='$2'
    cp -r "$OLDDIR/*" $NEWDIR
}
alias cpc='copyContents'

# Remote directory mounting
function mount_pplx {
    if [ -d ~/pplx ] ; then
        echo "pplx already mounted"
    else
        mkdir ~/pplx
        sshfs -o idmap=user pullen@pplxint8.physics.ox.ac.uk:/home/pullen ~/pplx
    fi
}
function mount_lxplus {
    if [ -d ~/lxplus ]; then
        echo "lxplus already mounted"
    else
        mkdir ~/lxplus
        sshfs -o idmap=user hpullen@lxplus.cern.ch:/afs/cern.ch/work/h/hpullen ~/lxplus
    fi
}
function mount_gangadir {
    if [ -d ~/gangadir ]; then
        echo "gangadir already mounted"
    else
        mkdir ~/gangadir
        sshfs -o idmap=user pullen@pplxint9.physics.ox.ac.uk:/data/lhcb/users/pullen/gangadir ~/gangadir
    fi
}
function unmount_all {
    if [ -d ~/pplx ]; then
        umount -f ~/pplx
        rmdir ~/pplx
        echo "pplx unmounted"
    else
        echo "pplx not currently mounted"
    fi
    if [ -d ~/lxplus ]; then
        umount -f ~/lxplus
        rmdir ~/lxplus
        echo "lxplus unmounted"
    else
        echo "lxplus not currently mounted"
    fi
    if [ -d ~/gangadir ]; then
        umount -f ~/gangadir
        rmdir ~/gangadir
        echo "gangadir unmounted"
    else
        echo "gangadir not currently mounted"
    fi
    # Put back git status
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
    source $ZSH/oh-my-zsh.sh
}
alias mp="mount_pplx && reloadDir"
alias mg="mount_gangadir && reloadDir"

# Unmount when exiting
alias exit="unmount_all && exit"

# tmux related aliases and functions
alias ks="tmux kill-session"
alias kp="tmux kill-pane"
alias kw="tmux kill-window"
alias td="tmux detach"
# Split tmux into three panes for coding
function tmux_coding {
    tmux split-window -h\;
    tmux split-window -v -p 20
}
# Get rid of all panes except the first
function tmux_normal {
    tmux kill-pane -a -t 0
}
# If in tmux, detach rather than exit
function exit {
    if [[ -z $TMUX ]]; then
        builtin exit
    else
        tmux detach
    fi
}
