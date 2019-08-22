export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export HISTSIZE=10000
alias ls='ls -GFh'
alias ll='ls -lA'

#bash vi mode
set -o vi
bind '"jj":"\e"'

cd $HOME/dot_files
. ./aliases.sh
. ./.inputrc

. $HOME/myscripts/*.*

export BUNDLE_EDITOR=vim
export EDITOR=vim
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

#bash completion, usage git branch re + Tab
if [ -f $HOME/.git-completion.bash ]; then
  . $HOME/.git-completion.bash
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

export PATH="/usr/local/opt/openssl/bin:$PATH"

#pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
eval "$(pyenv init -)"

#fasd ;;
eval "$(fasd --init auto)"

cd -

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
