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
function historygrep() {
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
alias dc_buildup='docker_compose_bu() { docker compose build && docker compose up; }; docker_compose_bu'

# Remove all Docker images
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
function dstop() {
    for container_id in $(docker ps -q); do
        docker stop "$container_id"
    done
}
