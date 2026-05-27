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
  aliases
  brew
  git
  podman
  thefuck
)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# Bitwarden SSH agent
# export SSH_AUTH_SOCK=~/.bitwarden-ssh-agent.sock

# Websupport
alias wss='TERM=xterm-256color ssh tadeas.bronis@37.9.169.175 -A'

# Dotfiles
alias dotfiles='code ~/Git/github/tadeasbronis/dotfiles'

# Python
alias python='python3.14'

export PATH="$HOME/.local/bin:$PATH"

# opencode completion
source <(opencode completion)
