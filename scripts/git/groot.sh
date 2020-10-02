here=$PWD
source ~/.zprofileLoader

if [[ $1 == "" ]]; then
    rootdir=$(git rev-parse --git-dir) && rootdir=$(cd "$rootdir" && pwd)/ && rootdir=${rootdir%%/.git/*}"/"
    echo "${rootdir}"
else
    #git repo name match
    while IFS=$',\r' read -r col1 col2 || [ -n "$col1" ]; do
        if [[ "$(gdirnamefromurl $col2)" == "$1" ]]; then
            expectedLocation="$col1/$1"
            if [[ $2 != "relative" ]]; then
                expectedLocation="$(checkGitsPrefix)$expectedLocation"
                if [[ -d "$expectedLocation" ]]; then
                    echo "$expectedLocation/"
                else
                    echoError "A repository with the name $1 has not been cloned in the expected location: $expectedLocation"
                fi
            else
                echo "$expectedLocation"
            fi
            exit
        fi
    done <"$(zprofileConfigDir)checkGits-repos.csv"
    echoError "A repository with the name $1 was not found in checkGits-repos.csv!"
fi
