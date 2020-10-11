here=$(cd "$(dirname "$0")" && pwd)

cd "$here"
cd ..

if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
    #check the shell is zsh
    if [[ $SHELL != '/bin/zsh' ]]; then
        sh "$(find . -iname "echoWarning.sh" -print -quit)" "Not using zsh! Scripts may not run correctly!"
        # echo "Changing to zsh..."
        # chsh -s /bin/zsh
        # echo "Now run this script again in a new terminal window and it should work!"
        # exit 0
    fi

    sh "$(find . -iname "compileZXProfile.sh" -print -quit)"
    source ~/.zxprofileLoader
    cd "$here"

    syncfiles
    checkGits $@
    installBundle
fi
