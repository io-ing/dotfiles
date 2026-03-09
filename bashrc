# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#用于输出当前目录所有文件及基本信息
alias ll='ls -al't config --global --list
alias fd='find ./ -name '
alias fgrep='find ./ -name "*.[ch]" | xargs grep'
alias ffgrep='find ./ -name "*" | xargs grep'
alias ggrep='find ./ -name "*" | xargs grep -rn'
alias gpush='git push origin HEAD:refs/for/master'
alias ggpush='git push origin HEAD:refs/for/master-development'
alias gbpush='git push origin HEAD:'
alias st='stty sane'
alias g='git'
alias gs='git status'
alias gsw='git show'
alias gl='git log'
alias gb='git branch'
alias gc='git cherry-pick'
alias gd='git diff --cached'
alias gdd='git diff'
alias ga='git add'
gcm() {
    git commit -m "$*"
}
alias ct='ctags -R --exclude=build .'
alias sqlite3='rlwrap sqlite3'
alias grh='git reset --hard origin/master'
alias hw='sshpass -p 'Fanvil@20251021' ssh user_test@172.16.250.205'
alias hw2='sshpass -p 'Fanvil@2024' ssh user_test@172.16.250.203'
alias hw3='sshpass -p 'Fanvil@2024' ssh user_test@172.16.250.204'

#function scp_work() {
function sw2() {
  local direction="$1"
  local filename="$2"
  local local_path="${3:-.}"  # 如果 $3 未提供，则默认为当前目录 "."
  local remote_path="/C:/Users/H/Downloads"
  #local remote_path="/C:/Users/T/Downloads/work"
  local remote_user="T"
  local remote_host="192.168.3.26"

  if [[ "$direction" == "up" ]]; then
    scp "$local_path/$filename" "$remote_user@$remote_host:$remote_path"
  elif [[ "$direction" == "down" ]]; then
    scp "$remote_user@$remote_host:$remote_path/$filename" "$local_path"
  else
    echo "Usage: scp_work <up|down> <filename> [<local_path>]" >&2
    return 1
  fi
}
function sw() {
  local direction="$1"
  local filename="$2"
  local local_path="${3:-.}"  # 如果 $3 未提供，则默认为当前目录 "."
  local remote_path="/C:/Users/H/Downloads"
  #local remote_path="/C:/Users/T/Downloads/work"
  local remote_user="H"
  local remote_host="172.16.25.175"

  if [[ "$direction" == "up" ]]; then
    scp "$local_path/$filename" "$remote_user@$remote_host:$remote_path"
  elif [[ "$direction" == "down" ]]; then
    scp "$remote_user@$remote_host:$remote_path/$filename" "$local_path"
  else
    echo "Usage: scp_work <up|down> <filename> [<local_path>]" >&2
    return 1
  fi
}

# rm 警告函数
rm() {
    echo -e "\033[31m警告：你正在使用 rm 命令删除文件，使用 mv 到 /tmp 代替！\033[0m"
}

export PATH=$PATH:$HOME/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.10
export VIRTUALENVWRAPPER_VIRTUALENV=~/.local/bin/virtualenv
source ~/.local/bin/virtualenvwrapper.sh

#export OPENAI_BASE_URL="https://www.88code.org/openai/v1"
#export OPENAI_API_KEY="88_5c362da62fd8d81dfd6c43dc247aeaf2cc403e8f88e88c339210224d87380f3d"

#export OPENAI_BASE_URL="http://172.16.25.192:23000/v1"
#export OPENAI_API_KEY="sk-24148c1212934e7de0073319898bcece"

#export CODE_ASSIST_ENDPOINT="https://www.88code.org/gemini"
#export GOOGLE_CLOUD_ACCESS_TOKEN="88_5c362da62fd8d81dfd6c43dc247aeaf2cc403e8f88e88c339210224d87380f3d"
#export GOOGLE_GENAI_USE_GCA="true"
