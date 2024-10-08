# Initialize Starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Transient Prompt
zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore-eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  PROMPT='$(starship module character)'
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}
zle -N zle-line-init

# Set up history
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

# Setup/Load zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Install zsh plugins
zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab \
  OMZP::git \
  OMZP::sudo \
  OMZP::command-not-found

# Load/style completions
# autoload -U compinit && compinit
# zinit cdreplay -q
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -A --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -A --color $realpath'

# Add shell integreations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

# Set programs variables
export EDITOR='nvim'

# Set keybindings
bindkey -e
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward

# Set aliases
alias ls='ls --color'
alias la='ls -A'
alias ll='ls -Al'
alias c='clear'

alias zshrc='${EDITOR} ${HOME}/.zshrc'
alias kittyrc='${EDITOR} ${HOME}/.config/kitty/kitty.conf'

alias mamba='micromamba'

alias gtk-theme='gsettings set org.gnome.desktop.interface gtk-theme'
alias icon-theme='gsettings set org.gnome.desktop.interface icon-theme'
alias dark-mode='gsettings set org.gnome.desktop.interface color-scheme prefer-dark'
alias light-mode='gsettings set org.gnome.desktop.interface color-scheme prefer-light'
function set-fonts() {
  local font_name="$1"
  local mono_font_name="$2"
  gsettings set org.gnome.desktop.interface font-name "$font_name"
  gsettings set org.gnome.desktop.interface document-font-name "$font_name"
  gsettings set org.gnome.desktop.interface monospace-font-name "$mono_font_name"
}

# Initialize node version manager for javascript
source /usr/share/nvm/init-nvm.sh

# Initialize micromamba for python
# export MAMBA_EXE='/usr/bin/micromamba';
# export MAMBA_ROOT_PREFIX='/home/kevin/.micromamba';
# __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
# if [ $? -eq 0 ]; then
#  eval "$__mamba_setup"
# else
#  alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
# fi
# unset __mamba_setup

# Enable zsh completions for auto-cpufreq
eval "$(_AUTO_CPUFREQ_COMPLETE=zsh_source auto-cpufreq)"
