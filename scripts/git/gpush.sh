here=$PWD
source ~/.zxprofileLoader

git push -u origin $(gbranchname)

if [[ $1 != "skippull" ]] && [[ $(gstatus) != *"Changes not staged for commit"* ]]; then
    # pull any new changes (also merge w/ default branch)
    gpull pushAfterMergingInDefaultBranch
else
    yarntest
fi
