#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
alias ll='ls -lA'

. ~/.profile
. ~/aliases.sh
cd ~/Desktop/Repository

export BUNDLE_EDITOR=vim
export EDITOR=vim
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

function rvm_version {
    local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}' | tr a-z A-Z)
    [ "$gemset" != "" ] && gemset="$gemset" 
    local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
    [ "$version" != "" ] && version="@$version"
    local full="$gemset$version"
    [ "$full" != "" ] && echo "$full "
}
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\] $(rvm_version)[$(git branch 2>/dev/null |grep "^*" |colrm 12)]\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\]'
