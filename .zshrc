# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# This loads nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

# Path to your oh-my-zsh installation.
export PF_INFO="ascii title os de host kernel uptime pkgs shell memory wm palette"
export PATH="$HOME/.poetry/bin:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin:$PATH"
export VISUAL="/usr/bin/micro"
export HISTFILE="$HOME/.zsh_history"
export HISTIGNORE="*sudo -S*"
export SAVEHIST=10000

# Zsh options
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_NO_STORE
setopt HIST_SAVE_NO_DUPS

# Load plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# Custom Bindings
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Aliases
alias zshconfig="micro ~/.zshrc"
alias py="python3"
alias pip="pip3"
alias nano="micro"
alias epoch='date +%s'
alias reload="source ~/.zshrc"
alias vblk="lsblk -o PATH,SIZE,RO,TYPE,MOUNTPOINT,UUID,MODEL"
alias yt="yt-dlp --sponsorblock-remove default"
alias ytx="yt-dlp -x --sponsorblock-remove intro,outro -o '%(uploader)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias config="/usr/bin/git --git-dir=/home/roxas/.cfg/ --work-tree=/home/roxas"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function op(){
	echo "Uploading $1..." 
	curl -F file=@"${1}" https://x0.at/
}

function ops(){
	PASS=$(openssl rand -base64 12)
	echo "Password: $PASS"
	zip -r -P "$PASS" "${1%.*}.zip" "$1"
	echo "Uploading ${1%.*}.zip..."
	curl -F file=@"${1%.*}.zip" https://x0.at/
	rm "${1%.*}.zip"
}

 # colorized alias list
function als {
  alias | sort \
  | sed -E -e "s|^([^=]*)=(.*)|${fg_bold[blue]}\1###${fg[white]}\2${reset_color}|" \
  | column -s '###' -t 
}

# generate random characters
function random {
  local character_count=${1:-32}
  local character_set=${2:-'A-Za-z0-9!#$%&()*+,-./:;<=>?@[]^_`{|}~'}
  head /dev/urandom | LC_ALL=C tr -dc $character_set | fold -w $character_count | head -1
}

# colorized diff
function diff {
  command diff "$@" | sed \
    -e "s|^\(<.*\)|${fg[red]}\1$reset_color|" \
    -e "s|^\(>.*\)|${fg[green]}\1$reset_color|" \
    -e "s|^\([a-z0-9].*\)|${fg_bold[cyan]}\1$reset_color|" \
    -l
  return ${pipestatus[1]}
}

export PATH="$HOME/.poetry/bin:$PATH"
