here=$PWD
source ~/.zxprofileLoader

compareUrl=$(gurl)/compare/$(gdefaultbranchname)...$(gbranchname)
echo $compareUrl

if [[ $(gdefaultbranchname) != $(gbranchname) ]]; then
    open $compareUrl
else
    echoError "$(greponame) is already on the default branch!"
fi
