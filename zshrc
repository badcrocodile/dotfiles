# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
 ZSH_THEME="random"
#ZSH_THEME="crcandy"
fpath=($HOME/.zsh/func $fpath)
typeset -U fpath
# Connections
alias wp3dev='ssh wp3dev.goshen.edu'
alias www3='ssh www3.goshen.edu'
alias www='ssh www.goshen.edu'
alias mygc='ssh mygc.goshen.edu'
alias maxx='ssh maxx.goshen.edu'
# Directories
alias htdocs='cd /Applications/XAMPP/xamppfiles/htdocs/'
alias gcdev='cd /var/www/wordpress/wp-content/themes/goshen/'
alias saos='cd /Applications/XAMPP/xamppfiles/htdocs/saos/'
# Files
alias hostsfile='sudo vim /etc/hosts'
alias knownhosts='vim /Users/jpollock/.ssh/known_hosts'
alias zshrc="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vimrcfile="vim ~/.vim/vimrc"
alias httpdfile="vim /Applications/XAMPP/xamppfiles/etc/httpd.conf"
alias vhostsfile="vim /Applications/XAMPP/xamppfiles/etc/extra/httpd-vhosts.conf"
alias xamppfiles="cd /Applications/XAMPP/xamppfiles/"
# XAMPP
alias xampprestart='sudo /Applications/XAMPP/xamppfiles/xampp restart'
alias xamppstart='sudo /Applications/XAMPP/xamppfiles/xampp start'
# MySQL
alias mysqlprompt='/Applications/XAMPP/xamppfiles/bin/mysql -u root -p'
# Lazy bastard
alias ..='cd ..'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'
alias now='date + "%T'
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(sublime web-search)

source $ZSH/oh-my-zsh.sh

# Enable Vi mode in command line
# bindkey -v
# Customize to your needs...

# Endable enhanced CD
cd_func ()
 {
   local x2 the_new_dir adir index
   local -i cnt
 
   if [[ $1 ==  "--" ]]; then
     dirs -v
     return 0
   fi
 
   the_new_dir=$1
   [[ -z $1 ]] && the_new_dir=$HOME
 
   if [[ ${the_new_dir:0:1} == '-' ]]; then
     #
     # Extract dir N from dirs
     index=${the_new_dir:1}
     [[ -z $index ]] && index=1
     adir=$(dirs +$index)
     [[ -z $adir ]] && return 1
     the_new_dir=$adir
   fi
 
   #
   # '~' has to be substituted by ${HOME}
   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
 
   #
   # Now change to the new dir and add to the top of the stack
   pushd "${the_new_dir}" > /dev/null
   [[ $? -ne 0 ]] && return 1
   the_new_dir=$(pwd)
 
   #
   # Trim down everything beyond 11th entry
   popd -n +11 2>/dev/null 1>/dev/null
 
   #
   # Remove any other occurence of this dir, skipping the top of the stack
   for ((cnt=1; cnt <= 10; cnt++)); do
     x2=$(dirs +${cnt} 2>/dev/null)
     [[ $? -ne 0 ]] && return 0
     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
     if [[ "${x2}" == "${the_new_dir}" ]]; then
       popd -n +$cnt 2>/dev/null 1>/dev/null
       cnt=cnt-1
     fi
   done
 
   return 0
 }
 
alias cd=cd_func
# END enhanced CD
