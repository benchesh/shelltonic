here=$PWD
source ~/.zprofileLoader

if [[ "$*" != "" ]]; then
    echo $(stat -f '%A' "$*")
else
    echoError "getPermssion cmd needs a filepath!"
fi
