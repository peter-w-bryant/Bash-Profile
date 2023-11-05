# Apply changes: source ~/.bashrc
alias bashrc='source ~/.bashrc'

# 1. -- Aliases --
alias c='clear'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias desktop='cd ~/Desktop'
alias documents='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias home='cd ~'
alias h='history'

# --- Python ---
alias py='python3'
alias penv='source env/Scripts/activate'

# Search for a string in the history
function hgrep() {
    history | grep "$1"
}

# --- GIT ---
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gs='git status'
alias gl='git log'
alias acp='function gitacp() { git add .; git commit -m "${1:-Updates}"; git push; }; gitacp' # Add, commit, push

# --- DOCKER ---
alias docker_compose_bu='docker_compose_bu() { docker compose build && docker compose up; }; docker_compose_bu'

# Remove all Docker images if no argument is passed, otherwise remove the image with the given name
function rmi() {
    if [ "$1" == "-a" ]; then
        docker rmi -f $(docker images -q)
        elif [ -z "$1" ]; then
        echo "Usage: rmi <image name> or rmi -a to remove all images"
    else
        docker rmi -f "$1"
    fi
}

# Stop all Docker containers
function docker_stop_all() {
    for container_id in $(docker ps -q); do
        docker stop "$container_id"
    done
}

# 2. -- Directory Navigation --
# --- Directory Navigation ---
# Quickly navigate to frequently accessed directories
function go() {
    case "$1" in
        docs) cd ~/Documents;;
        dl) cd ~/Downloads;;
        dt) cd ~/Desktop;;
        home) cd ~;;
        proj) cd C:/Projects;;
        *) echo "Don't know where to go?";;
    esac
}

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias mkdir='mkdir -pv' # Create directories with parents as needed and show output

alias back='cd "$OLDPWD"' # Go back to the previously visited directory

# 3. -- System Operations --
alias df='df -h' # Disk space in human readable form
alias du='du -ch' # Disk usage in human readable form

# Empty the Trash/Recycle bin from command line
alias emptytrash='rm -rf ~/.local/share/Trash/*'

# 4. -- Networking --
alias ports='netstat -tulanp' # List all used ports
alias myip='curl ipinfo.io/ip' # Get public IP address
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -' # Test internet speed

# Ping a host 5 times, default is google.com
function pingtest() {
    # default google.com
    ping -n 5 "${1:-google.com}"
}

# 5. -- Text Processing --
alias grep='grep --color=auto' # Highlight grep results
alias ngrep='grep -n' # grep with line numbers

# --- File Searching ---
# Search for a file with a given name in the current directory and subdirectories
# $1: The file name or pattern to search for
function fsearch() {
    find . -type f -name "$1"
}

# CD into the directory of the file returned by fsearch
# $1: The file name or pattern to search for
function fcd() {
    cd "$(dirname "$(fsearch "$1")")"
}

# 6. -- File and Directory Operations --
# Change permission of file to make it executable
function mkexec() {
    chmod +x "$1"
}

# Quick backup of a file
function backup() {
    cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
}

# 7. -- Process Management --
alias psg='ps aux | grep' # Process search

# Kill process by name
function killbyname() {
    pkill -f "$1"
}

# 8. -- Custom Prompt --
# This part is very personal, some like a minimalistic prompt, others want a full feature git integrated prompt.

# Minimal Prompt
PS1='\u@\h:\w\$ '

# 9. -- Misc --
# Extract most known archives with one command
function extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# 10. -- Additional GIT functions --
# Clone a repository and cd into it
function gclone() {
    git clone "$1" && cd "$(basename "$1" .git)"
}

# Check out a pull request locally
function gpr() {
    git fetch origin pull/"$1"/head:pr-"$1" && git checkout pr-"$1"
}

# Delete local branches that are not on remote
alias gclean='git fetch -p && git branch -vv | awk "/: gone]/{print $1}" | xargs git branch -d'

# Define colors
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
ORANGE='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
LIGHT_GRAY='\[\033[0;37m\]'
DARK_GRAY='\[\033[1;30m\]'
LIGHT_RED='\[\033[1;31m\]'
LIGHT_GREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
LIGHT_BLUE='\[\033[1;34m\]'
LIGHT_PURPLE='\[\033[1;35m\]'
LIGHT_CYAN='\[\033[1;36m\]'
WHITE='\[\033[1;37m\]'
NC='\[\033[0m\]' # No Color

# Example PS1
export PS1="${LIGHT_GREEN}\u@\h${NC}:${BLUE}\w${NC}\$ "
