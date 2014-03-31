if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

function parse_git_branch {
  ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

# Set the base PS1
export PS1="\t: \W$ "

# Source the git bash completion file
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    source ~/.git-prompt.bash
    PS1='\[\033[0;33m\][\W$(__git_ps1 " (%s)")]$ '
fi

export PS1

alias gco="git checkout"
alias ga="git add"
alias gci="git commit -m"
alias gs="git status"
alias gr="git rebase"
alias vpi="cd ~/ping"
alias vpb="cd ~/policy_builder"
alias pro="vim ~/.bash_profile"
alias rebash="source ~/.bash_profile"
alias start="~/bin/start_ping"
alias startold="~/bin/start_old_ping"
alias hosts="vim /etc/hosts"
alias sp="~/xml/submit_policy"
alias library="chflags nohidden ~/Library"
alias show_hidden_files="defaults write com.apple.finder AppleShowAllFiles TRUE"
alias hide_hidden_files="defaults write com.apple.finder AppleShowAllFiles FALSE"
alias gg="~/bin/gg.sh"
alias stop_sql="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
alias start_sql="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
alias pretty="~/xml/pretty_xml.rb"
##
# Your previous /Users/dave/.bash_profile file was backed up as /Users/dave/.bash_profile.macports-saved_2013-06-26_at_11:49:28
##

# MacPorts Installer addition on 2013-06-26_at_11:49:28: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
export RUBY_GC_MALLOC_LIMIT=90000000
export RUBY_FREE_MIN=2000000
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
