# -------------------------------- [START] P10K --------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme

# -------------------------------- [END] P10K --------------------------------

# -------------------------------- [START] ZINIT --------------------------------
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# -------------------------------- [END] ZINIT --------------------------------

# -------------------------------- [START] Completion --------------------------------
# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Keybindings
#bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# -------------------------------- [END] Completion --------------------------------


# -------------------------------- [START] MY STUFF --------------------------------
# [MY] exports
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.asdf/installs/rust/1.83.0/bin":$PATH
export PATH="$HOME/.asdf/installs/nodejs/23.4.0/bin":$PATH

# [MY] sources
. "$HOME/.asdf/asdf.sh"
#eval "$(fzf --zsh)"
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# [MY] alias
alias la="exa -lah  --icons --sort extension --group-directories-first"
alias ls="exa -lh  --icons --sort extension --group-directories-first"
alias ..="cd .."
alias cat="batcat"
# -------------------------------- [END] MY STUFF --------------------------------
