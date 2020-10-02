here=$PWD
source ~/.zprofileLoader

git fetch
branches=$(git branch -r)
if [[ $branches == *"$1"* ]]; then
    echoWarning "Branch already in existence! Switching to $1..."
    gcheckout "$1"
else
    gpull
    git checkout -b "$1"
    gpush
fi
