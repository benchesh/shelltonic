here=$PWD
source ~/.zxprofileLoader

if [[ $* == "" ]]; then
    git add .
else
    git add "$*"
fi
