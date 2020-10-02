here=$PWD
source ~/.zprofileLoader

if [[ $* == "" ]]; then
    git add .
else
    git add "$*"
fi
