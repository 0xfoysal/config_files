```
# Custom Aliases
alias ll='ls -la'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'

# Custom Functions
# Function to extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xvjf "$1" ;;
            *.tar.gz)  tar xvzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xvf "$1" ;;
            *.tbz2)    tar xvjf "$1" ;;
            *.tgz)     tar xvzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "Unsupported file format: $1" ;;
        esac
    else
        echo "File not found: $1"
    fi
}

# Function to find a file by name
findf() {
    find . -type f -iname "*$1*"
}

# Function to find a directory by name
findd() {
    find . -type d -iname "*$1*"
}
```
