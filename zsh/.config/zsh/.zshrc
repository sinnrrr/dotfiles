# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$XDG_DATA_HOME/oh-my-zsh"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=( 
  ansible
  aws
  brew
  docker
  docker-compose
  dotenv
  heroku
  git
  fzf
  rust
  pip
  poetry
  yarn
  terraform
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# to fix % on the terminal start (sometimes during yabai resizing)
setopt PROMPT_SP
export PROMPT_EOL_MARK=""

# p10k
P10K_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh"
[[ ! -f $P10K_PATH ]] || source $P10K_PATH

# fzf
FZF_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/fzf/.fzf.zsh"
[[ ! -f $FZF_PATH ]] || source $FZF_PATH

bindkey -v
unsetopt correct_all

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

eval "$(fnm env --use-on-cd)"
