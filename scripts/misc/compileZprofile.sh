here=$(cd "$(dirname "$0")" && pwd)

rootdir=$(git rev-parse --git-dir) && rootdir=$(cd "$rootdir" && pwd)/ && rootdir=${rootdir%%/.git/*}"/"
cd ~
printf "%s" "shellScriptsLocation=\"${rootdir}\""$'\n'"source \"\${shellScriptsLocation}.zprofileCompiled\"" >".zprofileLoader"

cd "$here"
cd ../..

cd "config/sync files"
fileAppend=$(cat zprofile.sh)
cd ../..

mkdir -p "executables"

cd scripts

allScripts=($(find . -type f -name "*.sh"))
for entry in ${allScripts[@]}; do
    relativePath="${entry#./}"
    commandName=$(basename "$(echo "$relativePath" | sed 's:[^/]*/\(.*\):\1:' | cut -d . -f 1)")
    fileAppend+=$'\n'"$commandName(){"$'\n'"	sh \"\$(zprofileScriptsDir)$relativePath\" \"\$@\""$'\n'"}"$'\n'

    relativePath=${relativePath%%.sh}.tool

    zprofileExecStr="cd \"\$(dirname \"\$0\")\""$'\n'
    zprofileExecStr+="rootdir=\$(git rev-parse --git-dir) && rootdir=\$(cd \"\$rootdir\" && pwd)/ && rootdir=\${rootdir%%/.git/*}\"/\""$'\n'
    zprofileExecStr+="cd \"\${rootdir}\""$'\n'
    zprofileExecStr+=""
    zprofileExecStr+="cmdName=\"\$(basename \"\$0\")\""$'\n'
    zprofileExecStr+="sh \"\$(find . -iname \"\${cmdName%%.*}.sh\" -print -quit)\" \$@"$'\n'
    zprofileExecStr+="source \".zprofileCompiled\""$'\n'
    zprofileExecStr+="endProcess"$'\n'

    cd "../executables"
    mkdir -p "$(dirname "$entry")"
    printf "%s" "$zprofileExecStr" >"$relativePath"
    cd ../scripts
done

cd ..

printf "%s" "$fileAppend" >".zprofileCompiled"

source ".zprofileCompiled"

#delete individual files/folders in the executables folder that don't exist in the zprofile folder
cd "executables"
allFiles=($(find . -iname "*" -print))
for entry in ${allFiles[@]}; do
    if [[ "${allScripts[*]}" != *"$(findAndReplace "$entry" .tool .sh)"* ]]; then
        trash "$entry"
    fi
done
cd ..

setPermission 755 "executables"

echo "Compiled zprofile"

syncfiles
