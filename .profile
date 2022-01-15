if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

function parse_git_branch {
  ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

# Set the base PS1
#export PS1="\e[31m\D{%F}\e[36m \D{%T}\e[37m \w • "
export PS1="\[\e[31m\]\d\[\e[m\] \[\e[36m\]\t\[\e[m\] \w • "
# Source the git bash completion file
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    source $HOME/.oh-my-git/prompt.sh
fi
export PS1

# History preservation
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
# AWS
export AWS_SDK_LOAD_CONFIG=true

alias gco="git checkout"
alias ga="git add"
alias gci="git commit -m"
alias gs="git status"
alias pro="vim ~/.profile"
alias rebash="source ~/.profile"
alias grb="git_recent_branches"

function git_recent_branches()
{
    if [[ $# -lt 1 ]]; then
	local count=8
    else
        local count=$1
    fi
    git checkout $(git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' --color | head -n $count | fzf --height 20%) 
}

function generate_files()
{
    if [[ $# -ne 4 ]]; then
        echo 'usage: generate_files { png | jpg | txt | bin } <count> <size> <directory>' >&2
        return 1
    fi

    local ext=$1; shift
    local count=$1; shift
    local size=$1; shift
    local dir=$1; shift

    mkdir -p "$dir"

    local i=0 fn
    while [[ $i -lt $count ]]; do
        (( ++i ))
        fn="$dir/file$(printf %03d $i).${ext}"
        printf '\r%s' "$fn"
        case "$ext" in
            png|jpg) convert -size "$size" plasma:fractal "$fn" || return ;;
            txt) return 22 ;;
            *) dd if=/dev/urandom of="$fn" bs=1 count="$size" >/dev/null 2>&1 || return ;;
        esac
    done
    echo
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

. "$HOME/.cargo/env"
