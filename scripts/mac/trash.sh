here=$PWD
source ~/.zxprofileLoader

cd "$(dirname "$*")"

trashPath="$(basename "$*")"

if [[ -d "$trashPath" ]] || [[ -f "$trashPath" ]]; then
    if [[ "$trashPath" != ".DS_Store" ]]; then
        osascript -e "tell application \"Finder\" to delete POSIX file \"${PWD}/$trashPath\""
        notify "Deleted $trashPath"
        sleep 1
    fi
else
    echoError "$* can't be trashed as it doesn't exist! (must be a relative path)"
fi

cd "$here"
