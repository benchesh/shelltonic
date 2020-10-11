here=$PWD
source ~/.zxprofileLoader

if [[ $(gbranchname) == "HEAD" ]]; then
    git checkout "$(gprevbranchname)"
fi

git pull
gmergeindefaultbranch $1

#get list of submodules
git submodule init
git submodule update --remote

if [[ $* != *"skipupdate"* ]]; then
    checkPkgInAllDirs $*
fi
