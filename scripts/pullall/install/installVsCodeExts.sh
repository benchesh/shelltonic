here=$PWD
source ~/.zxprofileLoader

#install vsCodeExtensions
if [[ $(code -v) == "" ]]; then
    echoError "To install VS Code extensions, you must first install VS Code!"
else
    vsCodeExtensions=()
    while read line || [ -n "$line" ]; do
        if [[ $line != "" ]] && [[ $line != *"#"* ]]; then
            vsCodeExtensions+=($line)
        fi
    done <"$(zxprofileConfigDir)vscode-extensions.sh"

    installedExtensions=$(code --list-extensions)
    for ext in ${vsCodeExtensions[@]}; do
        if [[ "$installedExtensions" != *"$ext"* ]]; then
            code --install-extension $ext
        fi
    done

    for ext in ${installedExtensions[@]}; do
        if [[ "${vsCodeExtensions[*]}" != *"$ext"* ]]; then
            unlistedVScodeExts+=$'\n'"$ext"
        fi
    done

    if [[ "$unlistedVScodeExts" != "" ]]; then
        echo "Unlisted VS Code extensions:"$'\n'"$unlistedVScodeExts"
    fi
fi
