# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  emoji
  git
  systemd
)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# Spaceship compat
# Note: For oh-my-zsh users with vi-mode plugin enabled: Add export RPS1="%{$reset_color%}" before source $ZSH/oh-my-zsh.sh in .zshrc to disable default <<< NORMAL mode indicator in right prompt.
# export RPS1="%{$reset_color%}"

source $ZSH/oh-my-zsh.sh

source ~/.config_spaceship
source ~/.config_vi_mode
source ~/.config_path
source ~/.config_shell
source ~/.config_maws
source /usr/share/nvm/init-nvm.sh
# This was an attempt to initialize nvm in the background, but spaceship's node integration seems to run it over and over.
# alias nvm="echo '[jfs] Initializing nvm...' && unalias nvm && source /usr/share/nvm/init-nvm.sh && nvm $@"
