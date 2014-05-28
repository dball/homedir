export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/opt/mysql55/bin:$PATH:~/bin
source /usr/local/opt/chruby/share/chruby/chruby.sh

alias vim=/usr/local/bin/vim
export EDITOR=/usr/local/bin/vim
export TERM=xterm-256color

# http://vvv.tobiassjosten.net/bash/dynamic-prompt-with-git-and-ansi-colors/
# Configure colors, if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    c_reset='\[\e[0m\]'
    c_user='\[\e[0;32m\]'
    c_path='\[\e[1;34m\]'
    c_git_clean='\[\e[0;37m\]'
    c_git_staged='\[\e[0;32m\]'
    c_git_unstaged='\[\e[0;31m\]'
else
    c_reset=
    c_user=
    c_path=
    c_git_clean=
    c_git_staged=
    c_git_unstaged=
fi

# Add the titlebar information when it is supported.
case $TERM in
xterm*|rxvt*)
    TITLEBAR='\[\e]0;\u@\h: \w\a\]';
    ;;
*)
    TITLEBAR="";
    ;;
esac

# Function to assemble the Git parsingart of our prompt.
git_prompt ()
{
    GIT_DIR=`git rev-parse --git-dir 2>/dev/null`
    if [ -z "$GIT_DIR" ]; then
        return 0
    fi
    GIT_HEAD=`cat $GIT_DIR/HEAD`
    GIT_BRANCH=${GIT_HEAD##*/}
    if [ ${#GIT_BRANCH} -eq 40 ]; then
        GIT_BRANCH="(no branch)"
    fi
    STATUS=`git status --porcelain`
    if [ -z "$STATUS" ]; then
        git_color="${c_git_clean}"
    else
        echo -e "$STATUS" | grep -q '^ [A-Z\?]'
        if [ $? -eq 0 ]; then
            git_color="${c_git_unstaged}"
        else
            git_color="${c_git_staged}"
        fi
    fi
    echo "[$git_color$GIT_BRANCH$c_reset]"
}

# Thy holy prompt.
#PROMPT_COMMAND="$PROMPT_COMMAND PS1=\"${TITLEBAR}${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}\$(git_prompt)\$ \" ;"
PROMPT_COMMAND="$PROMPT_COMMAND PS1=\"${TITLEBAR}${c_path}\w${c_reset}\$(git_prompt)\$ \" ;"

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
