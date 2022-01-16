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
export ZSH="/home/roxas/.oh-my-zsh"
export VISUAL="/usr/bin/micro"
export HISTIGNORE="*sudo -S*"

# Fuck node
#export NODE_OPTIONS="--openssl-legacy-provider"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_UPDATE_PROMPT="true"
UPDATE_ZSH_DAYS=3
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(git sudo autojump zsh-autosuggestions dirhistory dotenv)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Aliases
alias zshconfig="micro ~/.zshrc"
alias py="python3"
alias pip="pip3"
alias nano="micro"
alias yt="yt-dlp --sponsorblock-remove default"
alias ytx="yt-dlp -x --sponsorblock-remove intro,outro -o '%(uploader)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias reload="source ~/.zshrc"
alias vblk="lsblk -o PATH,SIZE,RO,TYPE,MOUNTPOINT,UUID,MODEL"
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
