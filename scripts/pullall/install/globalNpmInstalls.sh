here=$PWD
source ~/.zprofileLoader

cd ~
if cmdExists node; then
    globalNpmModules=()
    while read line || [ -n "$line" ]; do
        if [[ $line != "" ]] && [[ $line != *"#"* ]]; then
            globalNpmModules+=($line)
        fi
    done <"$(zprofileConfigDir)npm-globals.sh"

    outdatedGlobalNpmModules=$(npm outdated -g)
    globallyInstalledNpmModules=$(npm list -g --depth=0)

    printlines
    echo "Global npm modules:$globallyInstalledNpmModules"
    printlines

    updateStr="echo \"Installing/updating global npm modules...\""

    for npmMod in ${globalNpmModules[@]}; do
        if [[ $globallyInstalledNpmModules != *$npmMod'@'* ]]; then
            echo "Missing global npm module: $npmMod"
            updateStr+=" && sudo npm install -g $npmMod"
            installRequired=true
        fi
    done

    if [[ $outdatedGlobalNpmModules != "" ]]; then
        echoWarning "You have outdated global npm modules!"$'\n'"$outdatedGlobalNpmModules"
        printlines
        installRequired=true

        generateUpdateStr() {
            printf %s "$outdatedGlobalNpmModules" | while IFS= read -r line || [ -n "$line" ]; do
                if [[ $(echo $line | awk '{print $2}') != "Current" ]]; then
                    printf %s " && sudo npm install -g "$(echo $line | awk '{print $1}')
                fi
            done
        }

        updateStr+="$(generateUpdateStr)"
    else
        echo "Global npm modules are all up to date"
        printlines
    fi

    if [[ $installRequired == true ]]; then
        printlines
        if [[ $(isAdmin) == false ]]; then
            #provide install instructions if automatic install isn't possible
            echo "Global npm install/updates skipped as your account does not have admin priveledges.\nLog in to an admin account (ie. su $(printAdmin)) then run:\n$updateStr"
        else
            eval "$updateStr"

            printlines
            npm list -g --depth=0
        fi
    fi

else
    notify "Node isn't installed!"
    open https://nodejs.org/en/
fi
