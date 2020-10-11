here=$PWD
source ~/.zxprofileLoader

currentBranch=$(gbranchname)
git fetch origin
branches=$(git branch -r)
defaultBranch=$(gdefaultbranchname)

if [[ $(gstatus) == *"nothing to commit, working tree clean"* ]]; then
    if [[ $currentBranch != $defaultBranch ]]; then
        checkoutOutput=$(git checkout ${defaultBranch} && gpull skipupdate)
        echo "Checking out & pulling "$defaultBranch"...\n"$checkoutOutput"\nchecking out "$currentBranch" & merging with "$defaultBranch"..."
        git checkout $currentBranch

        mergeResult=$(git merge $defaultBranch)
        echo "$mergeResult"

        if [[ "$mergeResult" != *"Already up to date"* ]] && [[ "$mergeResult" != *"Automatic merge failed"* ]]; then
            if [[ $@ == *"pushAfterMergingInDefaultBranch"* ]]; then
                git push -u origin $currentBranch
            fi

            checkPkgInAllDirs
            yarntest
            gstatus
        fi
    fi
elif [[ $currentBranch != $defaultBranch ]]; then
    echo "Unstaged changes; $defaultBranch will not be merged into $currentBranch"
fi
