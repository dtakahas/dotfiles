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
alias stop_redis="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.redis.plist"
alias start_redis="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist"
alias pretty="~/xml/pretty_xml.rb"
alias coffee_timer="countdown '00:04:00'"
alias auth="cd ~/webauth"
alias core="cd ~/unitycloud-core-service"
alias collab="cd ~/unitycloud-collab-service"
alias ui="cd ~/unitycloud-core-ui"
alias common="cd ~/unitycloud-helpers"
alias les="less -Rginm"
##
# Your previous /Users/dave/.bash_profile file was backed up as /Users/dave/.bash_profile.macports-saved_2013-06-26_at_11:49:28
##

# MacPorts Installer addition on 2013-06-26_at_11:49:28: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/Users/davetakahashi/Library/Python/2.7/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
# Boost Ruby
export RUBY_GC_HEAP_INIT_SLOTS=1000000 # 1M
export RUBY_GC_HEAP_FREE_SLOTS=500000  # 0.5M
export RUBY_GC_HEAP_GROWTH_FACTOR=1.1
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=10000000 # 10M
export RUBY_GC_MALLOC_LIMIT_MAX=1000000000    # 1G
export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function countdown
{
        local OLD_IFS="${IFS}"
        IFS=":"
        local ARR=( $1 )
        local SECONDS=$((  (ARR[0] * 60 * 60) + (ARR[1] * 60) + ARR[2]  ))
        local START=$(date +%s)
        local END=$((START + SECONDS))
        local CUR=$START

        while [[ $CUR -lt $END ]]
        do
                CUR=$(date +%s)
                LEFT=$((END-CUR))

                printf "\r%02d:%02d:%02d" \
                        $((LEFT/3600)) $(( (LEFT/60)%60)) $((LEFT%60))

                sleep 1
        done
        IFS="${OLD_IFS}"
        echo "Coffee's ready!"
        /usr/bin/open -a "/Applications/Google Chrome.app" ~/Documents/coffee_ready.html 
}

function bundle-use-local
{ 
    if [ $# -ne 2 ]; then
        echo 'usage: bundle-use-local <gemname> <local_path>';
        return 1;
    fi;
    localrun 'bin script' bundle config --local "local.$1" "$2" && localrun 'bin script' bundle update "$1" && localrun 'bin script' bundle clean --force
}
function bundle-use-remote
{ 
    if [ $# -ne 1 ]; then
        echo 'usage: bundle-use-remote <gemname>';
        return 1;
    fi;
    localrun 'bin script' bundle config --delete "local.$1" && localrun 'bin script' bundle update "$1" && localrun 'bin script' bundle clean --force
}
function tailrun
{
    local tpid cmdrc;
    if [ $# -lt 2 -o ! -f "$1" ]; then
    echo 'usage: tailrun <file> <cmd> [<options>...]' 1>&2;
     return 1;
    fi;

    tail -Fn0 "$1" & tpid=$!;
    shift;
    "$@";
    cmdrc=$?;
    kill $tpid;
    return $cmdrc
}
function rspecl
{
    tailrun log/test.log rspec "$@"
}
