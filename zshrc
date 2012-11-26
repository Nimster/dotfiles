# Path to your oh-my-zsh configuration.
ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source ${ZSH}/oh-my-zsh.sh

setopt nobeep # No bell!

export HADOOP_INSTALL=/mnt/hd/nimrod/Code/hadoop-1.0.3
export HBASE_HOME=/mnt/hd/nimrod/Code/hbase-0.92.1
export GRADLE_HOME=/Users/nimster/Code/gradle-1.0
export JAVA_HOME=/Library/Java/JavaVirtualMachines/1.7.0.jdk/Contents/Home
export EMR_RUBY_HOME=${HOME}/Code/elastic-mapreduce-ruby
export LC_ALL=en_US.utf-8
export PIG_HOME=${HOME}/Code/pig-0.10.0
#export PIG_CLASSPATH="`${HBASE_HOME}/bin/hbase classpath`:$PIG_CLASSPATH"

export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/usr/texbin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/Users/nimster/.rvm/bin:/usr/local/sbin:${GRADLE_HOME}/bin:${HADOOP_INSTALL}/bin:${EMR_RUBY_HOME}:${PIG_HOME}/bin

alias la='ls -Gltrha'
alias less='less -n -R -Q'
alias grep='/usr/local/bin/grep' # Fixed grep-2.13 installed with HomeBrew
alias grp='grep -iHn --color=always'
alias emr='/usr/bin/ruby `which elastic-mapreduce`'
alias bc='bc -l'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

function emr_host {
  emr -j j-$1 --describe|grep -i MasterPublicDnsName | cut -d: -f 2 | cut -d '"' -f 2
}

function emr_tunnel {
  port=9100
  while [ $port -le 9200 ]
  do
    netstat -an | grep .${port} | grep -q LISTEN
    if (( $? ))
    then # No match
      break
    else
      port=$((port + 2))
    fi
  done
  portnext=$((port + 1))
  hostname=`emr_host $1`
  ssh -q -f -N -L ${port}:localhost:9100 -L ${portnext}:localhost:9101 hadoop@${hostname}
  if (( $? ))
  then
    echo "Error tunneling to ${hostname}"
  else
    echo "Tunneled to ${hostname} on http://localhost:${port}/ and http://localhost:${portnext}/"
  fi
}

function r_tunnel {
  ssh -f -N -L 8787:localhost:8787 $1
}

function sync_r_remote {
  rsync -avz --rsh=ssh --exclude-from=.gitignore DataSci/R ruser@$1:
}

function psgrep {
  ps auxwww | grep -i $1 | grep -v grep
}

function pskill {
  psgrep $1 | awk '{ print $2 }' | xargs kill $2
}

function s3size {
  s3cmd ls s3://$1 | awk '{print $3}' | ruby -e 'puts "#{STDIN.lines.map { |l| l.strip.to_i }.reduce(&:+) / (1024.0**2)} MB"'
}

alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'

function gencpath {
  ruby -e "puts Dir.glob('./*.jar').map { |k| Dir.pwd + k[1..-1] }.join(':')"
}

function rsum {
  ruby -e 'puts STDIN.reduce(0) { |s, l| s += l.strip.to_i }'
}

function unixtime {
  ruby -npe '$_=Time.at($_.to_i).utc + "\n"'
}

# export CLASSPATH=`ruby -e "puts # Dir.glob('{.,build,lib}/*.jar').join(':')"`

bindkey -v # VI mode
bindkey '^R' history-incremental-search-backward
unsetopt correct_all # Annoying corrections when using Hadoop
