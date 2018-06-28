#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
alias ll='ls -lA'
. ./aliases.sh
. ./.inputrc

export BUNDLE_EDITOR=vim
export EDITOR=vim
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#bash completion, usage git branch re + Tab
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

function parse_git_dirty {
  if [ -d ".git" ] || [ -f ".ruby-version" ]; then
    [[ $(git status | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
  fi
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\] $(rvm_version)$(parse_git_branch)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\]'
