here=$PWD
source ~/.zxprofileLoader

if [ $(pwdIsInGitRepo) ]; then
    packages="$(find . -name "package.json" -not -path "*node_modules*" -not -path "*.yalc*")"

    SAVEIFS=$IFS         # Save current IFS
    IFS=$'\n'            # Change IFS to new line
    packages=($packages) # split to array $names
    IFS=$SAVEIFS         # Restore IFS

    thisRepo=$(greponame)

    for item in "${packages[@]}"; do
        cd "$(dirname "$item")"
        if [[ $thisRepo == $(greponame) ]]; then
            checkPkg $*
        fi
        cd "$here"
    done
else
    echoWarning "To prevent accidental installations, checkPkgInAllDirs must run inside a git repo"
fi
