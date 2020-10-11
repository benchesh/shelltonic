here=$PWD
source ~/.zxprofileLoader

if [[ $* != "" ]]; then
    echo $(ls -ld "$*" | awk '{print $3}')
else
    owner "$here"
fi
