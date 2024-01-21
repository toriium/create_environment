# -------------------------------- [START] P10K --------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# -------------------------------- [END] P10K --------------------------------

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# -------------------------------- [START] MY STUFF --------------------------------
# [MY] exports
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.asdf/installs/rust/1.71.1/bin":$PATH
export PATH="$HOME/.asdf/installs/nodejs/21.5.0/bin":$PATH

# [MY] sources
. "$HOME/.asdf/asdf.sh"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# [MY] alias
alias la="exa -lah  --icons --sort extension --group-directories-first"
alias ls="exa -lh  --icons --sort extension --group-directories-first"
alias ..="cd .."
alias cat="batcat"
# -------------------------------- [END] MY STUFF --------------------------------
