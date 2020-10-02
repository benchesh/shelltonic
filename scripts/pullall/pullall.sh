here=$(cd "$(dirname "$0")" && pwd)

#check the shell is zsh
if [[ $SHELL != '/bin/zsh' ]]; then
    echoWarning() {
        COLOUR='\033[1;33m'
        NC='\033[0m' # No Color
        printf "${COLOUR}WARNING: ${NC}$*\n"
    }

    echoWarning "Not using zsh! Scripts may not run correctly!"
    # echo "Changing to zsh..."
    # chsh -s /bin/zsh
    # echo "Now run this script again in a new terminal window and it should work!"
    # exit 0
fi

# #if the gits folder doesn't exist, it's likely a first run of this script
# if [[ ! -f ~/.zprofileLoader ]]; then
#     initialRun=true
# fi

cd "$here"
cd ..

if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
    sh "$(find . -iname "compileZprofile.sh" -print -quit)"
    source ~/.zprofileLoader
    cd "$here"

    # if [[ $initialRun == true ]]; then
    #     oneTimeInstalls
    # fi

    checkGits $@
    installBundle
fi
