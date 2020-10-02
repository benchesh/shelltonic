here=$PWD
source ~/.zprofileLoader

if [[ $* != "" ]]; then
    echo $(ls -ld "$*" | awk '{print $3}')
else
    owner "$here"
fi
