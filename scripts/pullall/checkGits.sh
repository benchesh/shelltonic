here=$PWD
source ~/.zprofileLoader

cd "$(shellScriptsDir)"

shellScriptsRepo="$(greponame)"

branchNames=""
noOfBranchesNotOnDefaultBranch=0
totalNoOfRepositories=0
totalNoOfRepositoriesChecked=0
totalNoOfSubmodulesChecked=0

gpullx() {
    gpull "$1"

    if [[ $(gbranchname) != $(gdefaultbranchname) ]]; then
        noOfBranchesNotOnDefaultBranch=$((noOfBranchesNotOnDefaultBranch + 1))
        branchNames=$branchNames$'\n'"$(greponame) is on branch $(gbranchname)"
    fi

    gstatus
}

while IFS=$',\r' read -r col1 col2 col3 || [ -n "$col1" ]; do
    if [[ $(caseInsensitiveIncludes "$col1" "$1") == false ]]; then
        continue
    fi

    currentDir="$(checkGitsPrefix)$col1"

    printlines
    echo "${currentDir}"

    if [[ -d "${currentDir}" ]]; then
        cd "${currentDir}"
        if ! [ "$(ls -A)" ]; then
            rmdir "${currentDir}"
            echo "Removed empty folder"
        fi
    fi

    totalNoOfRepositories=$((totalNoOfRepositories + 1))

    printlines
    repo=$(gdirnamefromurl $col2)

    #test the user can connect to the git's domain
    #TODO: TEST ENTIRE GIT URL... TRUNCATED AS THERE ARE UNKNOWN ISSUES WHEN PASSING THE FULL COL2 VALUE TO CURL/ECHO
    if [[ "$col2" == "https"* ]]; then
        domainTest=${col2/*:\/\//}
        domainTest=${domainTest%%\/*}

        if [[ $(curl -Is --connect-timeout 1 https://$domainTest | head -1) != *'HTTP'* ]]; then
            echo $repo
            echoError "Connection timed out!"
            continue
        fi
    fi

    mkdirGo ${currentDir}
    gclone "$col2"

    cd ${repo}

    gpullx "$col3"

    totalNoOfRepositoriesChecked=$((totalNoOfRepositoriesChecked + 1))

    if [[ ${repo} == $shellScriptsRepo ]]; then
        compileZprofile
    fi

    cd "$(zprofileConfigDir)"
    submodulesFile="checkGits-submodules/$col1/$repo.sh"

    if [[ -f "$submodulesFile" ]]; then

        #get list of submodules
        allSubmodules=()
        while read subMod || [ -n "$subMod" ]; do
            if [[ $subMod != "" ]] && [[ $subMod != *"#"* ]]; then
                allSubmodules+=($subMod)
            fi
        done <"$submodulesFile"

        getSubmodule() {
            printlines
            echo $1
            cd "${currentDir}/${repo}/$1"
            gpullx
            totalNoOfSubmodulesChecked=$((totalNoOfSubmodulesChecked + 1))
        }

        for ((subMod = 0; subMod < ${#allSubmodules[*]}; subMod++)); do
            getSubmodule ${allSubmodules[$subMod]}
        done

        printlines
    fi

done <"$(zprofileConfigDir)checkGits-repos.csv"

printlines

echo $totalNoOfRepositoriesChecked / $totalNoOfRepositories repositories checked
echo $totalNoOfSubmodulesChecked / $totalNoOfSubmodulesChecked submodules checked

printlines

echo "Repos not on the default branch: "$noOfBranchesNotOnDefaultBranch$'\n'"$branchNames"

notify checkGits complete

printlines
