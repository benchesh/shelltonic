here=$(cd "$(dirname "$0")" && pwd)

cd "$here"
rootdir=$(git rev-parse --git-dir) && rootdir=$(cd "$rootdir" && pwd)/ && rootdir=${rootdir%%/.git/*}"/"
cd ~
printf "%s" "zxprofileScriptsDirVar=\"${rootdir}scripts/\""$'\n'"if [[ ! -f \"${rootdir}scripts/.zxprofileCompiled\" ]]; then"$'\n'"	sh \"${rootdir}install.tool\""$'\n'"fi"$'\n'"source \"${rootdir}scripts/.zxprofileCompiled\"" >".zxprofileLoader"

printf "%s" "if [[ -f \"${rootdir}scripts/zxprofileHead.sh\" ]]; then"$'\n'"	source \"${rootdir}scripts/zxprofileHead.sh\""$'\n'"	echo \"zxprofile loaded!\""$'\n'"else"$'\n'"	echo \"Uh oh. zxprofile failed to load because \\\"${rootdir}scripts/zxprofileHead.sh\\\" does not exist!\""$'\n'"fi" >".zprofile"

cd "$here"
cd ../..

cd "scripts"
fileAppend=$(cat zxprofileHead.sh)
cd ..

mkdir -p "executables"

cd scripts

allScripts=($(find . -type f -name "*.sh"))
for entry in ${allScripts[@]}; do
    relativePath="${entry#./}"
    commandName=$(basename "$(echo "$relativePath" | sed 's:[^/]*/\(.*\):\1:' | cut -d . -f 1)")
    fileAppend+=$'\n'"$commandName(){"$'\n'"	sh \"\$zxprofileScriptsDirVar\"\"$relativePath\" \"\$@\""$'\n'"}"$'\n'

    relativePath=${relativePath%%.sh}.tool

    zxprofileExeStr="cd \"\$(dirname \"\$0\")\""$'\n'
    zxprofileExeStr+="rootdir=\$(git rev-parse --git-dir) && rootdir=\$(cd \"\$rootdir\" && pwd)/ && rootdir=\${rootdir%%/.git/*}\"/\""$'\n'
    zxprofileExeStr+="cd \"\${rootdir}\""$'\n'
    zxprofileExeStr+=""
    zxprofileExeStr+="cmdName=\"\$(basename \"\$0\")\""$'\n'
    zxprofileExeStr+="sh \"\$(find . -iname \"\${cmdName%%.*}.sh\" -print -quit)\" \$@"$'\n'
    zxprofileExeStr+="source ~/.zxprofileLoader"$'\n'
    zxprofileExeStr+="endProcess"$'\n'

    cd "../executables"
    mkdir -p "$(dirname "$entry")"
    printf "%s" "$zxprofileExeStr" >"$relativePath"
    cd ../scripts
done

printf "%s" "$fileAppend" >".zxprofileCompiled"

cd ..

source ~/.zxprofileLoader

#delete individual files/folders in the executables folder that don't exist in the zxprofile/scripts folder
cd "executables"
allFiles=($(find . -iname "*" -print))
for entry in ${allFiles[@]}; do
    if [[ "${allScripts[*]}" != *"$(findAndReplace "$entry" .tool .sh)"* ]]; then
        trash "$entry"
    fi
done
cd ..

setPermission 755 "executables"

echoGreen "Compiled zxprofile!"
