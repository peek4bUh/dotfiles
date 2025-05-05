#
#       ███████╗███████╗██╗  ██╗██████╗  ██████╗
#       ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#         ███╔╝ ███████╗███████║██████╔╝██║
#        ███╔╝  ╚════██║██╔══██║██╔══██╗██║
#    ██╗███████╗███████║██║  ██║██║  ██║╚██████╗
#    ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
#    author: peek4bUh
#    repo:   https://github.com/peek4bUh/dotfiles
#


export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

source "$XDG_CONFIG_HOME/zsh/.aliasrc"

autoload -Uz compinit
zstyle ':completion:*' menu select
compinit
_comp_options+=(globdots)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export GPG_TTY=\$(tty)

# Emacs bindings
bindkey -e

#picom --config ~/.config/picom/picom.conf &

export PATH=$HOME/.config/rofi/scripts:$PATH
