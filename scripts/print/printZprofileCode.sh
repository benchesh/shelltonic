here=$PWD
source ~/.zprofileLoader

cd "$(zprofileScriptsDir)"
filepath=$(find . -iname "$1.sh" -print -quit)

if [[ "$filepath" != "" ]]; then
    printf "%s\n" "$(cat $filepath)"
else
    echoError "$1 command not found!"
fi
