here=$PWD
source ~/.zxprofileLoader

#go to path of root git folder
cd "$(groot)"

gpull skipupdate
gadd

SAVEIFS=$IFS                                                         # Save current IFS
IFS=$'\n' read -d '' -r -a arr <<<"$(git diff --name-only --cached)" # Convert string to array
IFS=$SAVEIFS                                                         # Restore IFS

commitMessage="Quick commit:"
for Item in "${arr[@]}"; do
    if ((${#commitMessage} > 80)); then
        commitMessage="$(echo $commitMessage | sed 's/.$//') & more,"
        break
    fi
    if ((${#Item} > 20)); then
        Item="...${Item:(-15)}"
    fi
    commitMessage="$commitMessage \"$Item\","
done

gcommit "$(echo $commitMessage | sed 's/.$//')"
gpush
