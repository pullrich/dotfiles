if [ -f ./work.bashrc ]; then
    . ./work.bashrc
fi

# file permissions: rwxr-xr-x
#
umask	022

[[ $- = *i* ]] && bind TAB:menu-complete
# Aktiviere Tab-Vervollständigung. siehe: https://superuser.com/questions/59175/is-there-a-way-to-make-bash-more-tab-friendly
bind '"\e[Z":menu-complete-backward'
# Mit Shift+Tab einen Eintrag in der Tab-Vervollständigung zurück gehen.

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
# m: Enthält dann z.B. 'more' (statt less) als Pager.
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

# ShellCheck mit Parameter für POSIX Shell
alias shck='shellcheck -s sh'

# c = configure ... bash, etc.
alias cbash='vim ~/.bashrc'
alias cvim='vim ~/.vimrc'

#BASE_PROMPT="USER@HOST SHELL_LEVEL"
BASE_PROMPT="\u@\h (`tty | sed 's/\/dev\///'`) \w \#SHELL_LEVEL\n>"
# Promp Definition 
if [ "x$SHLVL" = "x1" ]; then
    BASE_PROMPT="${BASE_PROMPT/SHELL_LEVEL/}"
    # replace SHELL_LEVEL with nothing

    #PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\\$\[\e[m\] "
else
    BASE_PROMPT="${BASE_PROMPT/SHELL_LEVEL/($SHLVL)}"
    # replace SHELL_LEVEL with variable value
fi
PS1="\e[1;32m$BASE_PROMPT\e[m "
# Color propmt green.

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

