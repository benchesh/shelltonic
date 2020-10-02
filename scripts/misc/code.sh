#run vscode cli commands w/out installing 'code' command in PATH within vscode
if [[ -f "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" $*
fi
