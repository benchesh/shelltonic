here=$PWD
source ~/.zxprofileLoader

cd "$(checkGitsPrefix)"

repos="$(find . -name ".git" -not -path "*node_modules*" -not -path "*.yalc*")"

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
repos=($repos) # split to array $names
IFS=$SAVEIFS   # Restore IFS

here=$PWD

for item in "${repos[@]}"; do
    cd "$(dirname "$item")"
    if [[ $(greponame) == $1 ]]; then
        pwd
        exit
    fi
    cd "$here"
done
