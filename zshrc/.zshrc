# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"

# Disable Oh My Zsh theme (using Starship instead)
ZSH_THEME=""

# plugins
plugins=(
  aliases
  brew
  git
  podman
  thefuck
)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

export EDITOR="/opt/homebrew/bin/nvim"

source $ZSH/oh-my-zsh.sh

# Bitwarden SSH agent
# export SSH_AUTH_SOCK=~/.bitwarden-ssh-agent.sock

# Websupport
alias wss='TERM=xterm-256color ssh tadeas.bronis@37.9.169.175 -A'

# Dotfiles
alias dotfiles='${EDITOR} ~/Git/github.com/tadeasbronis/dotfiles'

# Python
alias python='python3.14'

export XDG_CONFIG_HOME="$HOME/.config"

# opencode completion
source <(opencode completion)

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
