here=$PWD
source ~/.zxprofileLoader

timenow="$(findAndReplace "$(date -r $(timestamp))" : -)"

echo syncfiles

comparefiles() {
    cd "$(zxprofileConfigDir)sync files"
    srcFile="$1"
    destDir="$(dirname "$2")"
    destFile="$(basename "$2")"

    # go back to zxprofileDir if file does not exist in sync files folder
    if [[ ! -f "$srcFile" ]]; then
        cd "$(zxprofileDir)"
    fi

    if [[ -f "$srcFile" ]] && [[ -d "$destDir" ]]; then
        srcFileCat=$(cat "$srcFile")
        srcFilePermission=$(getPermission "$srcFile")

        cd "$destDir"

        destFileCat=false
        if [[ -f "$destFile" ]]; then
            destFileCat=$(cat "$destFile")
        fi

        if [[ "$srcFileCat" == "$destFileCat" ]]; then
            echo "$destFile" file is already up to date
        else
            #use printf %s to preserve the escaped newlines
            printf "%s" "$srcFileCat" >"$destFile"
            echoGreen overwritten "$destFile" file!
            sleep 1

            if [[ "$destFileCat" != false ]]; then
                cd ~
                mkdirGo "zxprofile sync backups/$timenow/$destDir"
                printf "%s" "$destFileCat" >"$destFile"
            fi

            cd "$(zxprofileConfigDir)sync files"

            # #auto commit any changes
            # if [ $(pwdIsInGitRepo) ]; then
            #     # go back to zxprofileDir if file does not exist in sync files folder
            #     if [[ ! -f "$srcFile" ]]; then
            #         cd "$(zxprofileDir)"
            #     fi

            #     gpull
            #     git add "$srcFile"
            #     git commit -o "$srcFile" -m "Automatic commit: \"$srcFile\""
            #     gpush
            # fi
        fi

        #match destFileCat's permission with srcFileCat
        cd "$destDir"
        if [[ $srcFilePermission != $(getPermission "$destFile") ]]; then
            setPermission $srcFilePermission "$destFile"
        fi
    else
        errMsg="syncfiles ERROR: "
        if [[ ! -f "$srcFile" ]]; then
            errMsg+="$srcFile does not exist!"
        fi
        if [[ ! -d "$destDir" ]]; then
            errMsg+="directory $destDir does not exist!"
        fi
        echo "$errMsg"
    fi
}

while IFS=$',\r' read -r col1 col2 || [ -n "$col1" ]; do
    comparefiles "$col1" ~/"$col2"
done <"$(zxprofileConfigDir)sync files/locations.csv"

notify Files synced!

cd "$here"
