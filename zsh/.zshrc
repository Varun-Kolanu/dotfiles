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

# Changes to the given directory after running yazi with the given arguments.
#
# This is a wrapper around yazi that allows it to change directories. It
# does this by running yazi with the --cwd-file option and then changing
# directories to the given file. The temporary file is then removed.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# env
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"

# aliases
#alias vim="nvim"
alias viz="vim ~/.zshrc"
alias vin="vim ~/.config/nvim/init.vim"
alias vih="code dotfiles && code ~/dotfiles/hypr/.config/hypr/hyprland.conf"
alias viw="vim ~/dotfiles/waybar/.config/waybar/config.jsonc"
alias clr="clear; fastfetch;"
alias obsync_down="rclone sync ObsidianSync:Obsidian ~/Documents/Hyprland -vv"
alias obsync_up="rclone sync ~/Documents/Hyprland ObsidianSync:Obsidian -vv"
alias booksync_up="rclone sync ~/Documents/Books ObsidianSync:Books -vv"
alias booksync_down="rclone sync ObsidianSync:Books ~/Documents/Books -vv"
alias cz="code ~/Coding/zulip"

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
export RCLONE=$(which rclone)
export RCLONE=$(which rclone)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
