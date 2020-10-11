here=$PWD
source ~/.zxprofileLoader

if [[ "$*" != "" ]]; then
    echo $(stat -f '%A' "$*")
else
    echoError "getPermssion cmd needs a filepath!"
fi
