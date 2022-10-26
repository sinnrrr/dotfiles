# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End

ZVM_VI_HIGHLIGHT_FOREGROUND=green
ZVM_VI_HIGHLIGHT_BACKGROUND=white
SHELL="/bin/zsh" # skhd related fix
# silence asdf-direnv
export DIRENV_LOG_FORMAT=
ZVM_CURSOR_STYLE_ENABLED=false
zstyle ':completion:*' menu select
zle_highlight+=(paste:none) # no highlight on paste
setopt autocd	interactive_comments
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Don't bind these keys until ready
bindkey -r '^[[A'
bindkey -r '^[[B'

function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}

function _zinit_asdf_install() {
  # path export temporary required so the asdf script finds itself
  PATH="${PWD}/bin:$PATH"
  asdf plugin add direnv
  asdf install direnv latest
  asdf global direnv latest
  # see https://github.com/asdf-community/asdf-direnv#setup
  asdf exec direnv hook zsh > asdf_direnv_hook.zsh
  echo 'direnv() { asdf exec direnv "$@"; }' >> asdf_direnv_hook.zsh
}

zinit ice lucid as"program" \
    pick'bin/asdf' atinit'export ASDF_DIR="$PWD"' \
    atclone'_zinit_asdf_install' src'lib/asdf.sh' \
    multisrc'asdf_direnv_hook.zsh' depth=1
zinit light asdf-vm/asdf

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Regular plugins, loaded in turbe mode (wait)
zinit wait lucid light-mode for \
  OMZP::golang \
  OMZP::terraform \
  \
  as"completion" \
  OMZP::docker/_docker \
  \
  as"completion" \
  OMZP::docker-compose/_docker-compose \
  \
  atload'__bind_history_keys' \
  zsh-users/zsh-history-substring-search \
  \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
  zdharma/fast-syntax-highlighting \
  \
  atload"!_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions \
  \
  blockf atpull'zinit creinstall -q .' \
  zsh-users/zsh-completions \
  \
  as"completion" atclone='kubectl completion zsh > _kubectl' \
  atpull'%atclone' has'kubectl' nocompile blockf \
  id-as'kubectl' \
  zdharma-continuum/null 
  
autoload -U colors && colors

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# [[ -n $(ls ~/.zshrc.d/) ]] && for file in ~/.zshrc.d/*; do source "${file}"; done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
