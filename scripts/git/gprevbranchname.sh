here=$PWD
source ~/.zxprofileLoader

prevBranch=$(git rev-parse --abbrev-ref @{-1})

if [[ "$prevBranch" == "" ]]; then
    echo $(gdefaultbranchname)
else
    echo "$prevBranch"
fi
