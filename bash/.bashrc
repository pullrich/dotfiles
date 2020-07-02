if [ -f ./work_aliases.bashrc ]; then
    . ./work_aliases.bashrc
fi

# file permissions: rwxr-xr-x
#
umask	022

[[ $- = *i* ]] && bind TAB:menu-complete
# Aktiviere Tab-Vervollst�ndigung. siehe: https://superuser.com/questions/59175/is-there-a-way-to-make-bash-more-tab-friendly
bind '"\e[Z":menu-complete-backward'
# Mit Shift+Tab einen Eintrag in der Tab-Vervollst�ndigung zur�ck gehen.

# Netter Trick ...
#sudo ls -l | sudo dd of=/prod/test.txt
# ... falls man nicht in eine Datei umleiten darf (also "sudo ls -l > test.txt" ist nicht erlaubt) kann man es so dennoch erreichen.
# Siehe: https://stackoverflow.com/a/8213307

# Uncomment next line to enable the builtin emacs(1) command line editor
# in sh(1), e.g. C-a -> beginning-of-line.
# set -o emacs

PAGER="less"; export PAGER;

# some useful aliases
alias h='fc -l'
alias j=jobs
# m: Enth�lt dann z.B. 'more' (statt less) als Pager.
alias m='$PAGER'
alias ll='ls -laFo'
alias llh='ls -laFoh'
alias l='ls -l'

# Meine Aliase
alias g='gmake'
alias gi='gmake install'
alias gmc='gmake clean' # gc should not be use because of it being the gnu-compiler
alias vimeod='vim -S ~/vimsess/eod-session.vim' # start vim with eod-session (end of day).
# svn (c)ommit (k)eep... (n)o...
alias svnckn='svn commit --keep-changelists --no-unlock'

# ShellCheck mit Parameter f�r POSIX Shell
alias shck='shellcheck -s sh'

# c = configure ... bash, etc.
alias cbash='vim ~/.bashrc'
alias cvim='vim ~/.vimrc'


# Promp Definition 
if [ "x$SHLVL" = "x1" ]; then
    #PS1="=== \u@\h (`tty | sed 's/\/dev\///'`) \w \# -> "

    BASE_PROMPT="=== \u@\h (`tty | sed 's/\/dev\///'`) \w \# -> "
    PS1="\e[1;32m$BASE_PROMPT\e[m "

    #PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\\$\[\e[m\] "
else
    #PS1="=== \u@\h (`tty | sed 's/\/dev\///'`) \w \#($SHLVL) -> "
    BASE_PROMPT="=== \u@\h (`tty | sed 's/\/dev\///'`) \w \#($SHLVL) -> "
    PS1="\e[1;32m$BASE_PROMPT\e[m "
fi

PS2="\u@\h \w \! ++ "

SVN_EDITOR="vim"; export SVN_EDITOR;

function cdatetime() {
    date +'%Y-%m-%dT%H-%M-%S'
}

function cdate() {
    date +'%Y-%m-%d'
}

function ctime() {
    date +'%H-%M-%S'
}

