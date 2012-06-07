stty -ixon # Prevents Ctrl+S,Ctrl+Q from being bound, so you can use them in readline

export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:${PATH}"

alias la='ls -Gltrha'
alias less='less -n -R -Q'
alias grp='grep -iHn --color=always'
alias pylab='ipython --pylab'
alias rakeprod='RAILS_ENV=production bundle exec rake'
export PS1='\[\e[1;34m\]\w\$\[\e[0m\] '

function probe {
  find . -iname "*.$1" -exec grep -iHEn --color=always $2 '{}' ';'
}

function clear_ssh {
  grep -v $1 ~/.ssh/known_hosts > ~/.ssh/known_hosts.bak && cp ~/.ssh/known_hosts.bak ~/.ssh/known_hosts
}

function psgrep {
  ps auxwww | grep $1 | grep -v grep
}

function cnt_run {
  psgrep $1 | wc -l
}

function pskill {
  psgrep $1 | awk '{ print $2 }' | xargs kill $2
}

. ~/.bash/rake_complete.sh

[[ -s "/Users/nimster/.rvm/scripts/rvm" ]] && source "/Users/nimster/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

