# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# zsh theme settings
ZSH_THEME="dracula"
DRACULA_DISPLAY_TIME=1
DRACULA_DISPLAY_CONTEXT=1
DRACULA_DISPLAY_FULL_CWD=1
DRACULA_DISPLAY_NEW_LINE=1

# plugins
plugins=(
  git
  aliases
)

source $ZSH/oh-my-zsh.sh

# Websupport
alias wss='TERM=xterm-256color ssh tadeas.bronis@37.9.169.175 -A'