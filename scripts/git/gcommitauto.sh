here=$PWD
source ~/.zprofileLoader

##TODO FINISH THIS

# git pull

# make it run before git push. check previous 2 commits and if file lists exist, reset and commit ONLY those files!
#check the repo is up to date and the commit message is identical to the most recent one
# if [[ "$(gstatus)" == *"branch is up to date"* ]] && [[ $(git log -1 --pretty=%B) == "$1" ]]; then
#     echo "Overwriting previous commit..."

#     gremovelastcommit
# fi

# gcommit "$1"
