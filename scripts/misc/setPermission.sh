here=$PWD
source ~/.zxprofileLoader

if [[ "$*" != "" ]]; then
    chmod -R $1 "${*:2}"
else
    echoError "setPermssion cmd needs a filepath!"
fi
