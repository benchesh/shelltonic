here=$PWD
source ~/.zprofileLoader

if [[ $(printAdmin) == $(owner ~) ]]; then
    echo true
else
    echo false
fi
