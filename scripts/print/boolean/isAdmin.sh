here=$PWD
source ~/.zxprofileLoader

if [[ $(printAdmin) == $(owner ~) ]]; then
    echo true
else
    echo false
fi
