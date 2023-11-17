# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi 

# Maps Ctrl+h (also backspace) to delete the previous word
bind '"\C-h": backward-kill-word' 