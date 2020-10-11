here=$PWD
source ~/.zxprofileLoader

str=$(echo $(basename $(git symbolic-ref --short refs/remotes/origin/HEAD)))

if [[ "$str" == "" ]]; then
    #if symbolic-ref does not work, access the remote instead (cause of bug is unknown)
    echo $(git ls-remote --symref $(gurl) HEAD | awk '/^ref:/ {sub(/refs\/heads\//, "", $2); print $2}')
else
    echo "$str"
fi
