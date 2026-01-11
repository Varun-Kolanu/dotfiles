# Location + size
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# History behavior
setopt append_history          # don’t overwrite history file
setopt inc_append_history      # write each command immediately
setopt share_history           # share between all running shells
setopt hist_ignore_dups        # don’t record duplicates
setopt hist_ignore_all_dups    # delete old duplicate commands
setopt hist_ignore_space       # ignore commands starting with space
setopt hist_reduce_blanks      # remove superfluous blanks
setopt hist_verify             # show before executing history expansion
setopt extended_history        # record timestamp of each command

bindkey '^R' history-incremental-search-backward
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# env
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"

# aliases
#alias vim="nvim"
alias viz="vim ~/.zshrc"
alias vin="vim ~/.config/nvim/init.vim"
alias vih="code dotfiles && code ~/dotfiles/hypr/.config/hypr/hyprland.conf"
alias viw="code ~/dotfiles/waybar/.config/waybar/config.jsonc"
alias clr="clear; fastfetch;"

# antidote setup
source '/usr/share/zsh-antidote/antidote.zsh'
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
# zsh-autosuggestions
bindkey '^ ' autosuggest-accept      
bindkey '^E' autosuggest-execute

# starship prompt init
eval "$(starship init zsh)"
clr
[[ -f ~/.ssh/agent.env ]] && source ~/.ssh/agent.env

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
export TERMINAL=wezterm

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

#eval "$(zoxide init zsh)"
