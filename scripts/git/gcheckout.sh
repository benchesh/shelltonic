here=$PWD
source ~/.zprofileLoader

git fetch

branches=($(git branch -r))
options=()

performCheckout() {
    echo "Checking out $1"
    current_branch=$(gbranchname)
    if [[ $current_branch != $1 ]]; then
        echo "switching from branch $current_branch to $1..."
        git checkout $1
        # yremove
        # yarn cache clean
    else
        echo "already on branch $current_branch"
    fi
    gpull
}

if [[ $1 == "-" ]]; then
    performCheckout $(gprevbranchname)
    exit
fi

for branch in ${branches[@]}; do
    if [[ $branch == *"$1"* ]]; then
        options+=($(cut -d "/" -f2- <<<"$branch"))
    fi
done

options=($(echo "${options[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

if [[ ${#options[*]} == 1 ]]; then
    performCheckout ${options[0]}
elif [[ ${#options[*]} > 0 ]]; then
    #the following is based on this thread: https://serverfault.com/questions/144939/multi-select-menu-in-bash-script

    menu() {
        echo "Multiple possible branches were found!"
        for i in ${!options[@]}; do
            printf "%3d%s) %s\n" $((i + 1)) "${choices[i]:- }" "${options[i]}"
        done
        if [[ "$msg" ]]; then echo "$msg"; fi
    }

    # prompt="Check an option (again to uncheck, ENTER when done): "
    prompt="Type a number and hit ENTER to checkout (will default to first option): "
    while menu && read -rp "$prompt" num && [[ "$num" ]]; do
        [[ "$num" != *[![:digit:]]* ]] &&
            ((num > 0 && num <= ${#options[@]})) ||
            {
                msg="Invalid option: $num"
                continue
            }
        ((num--))
        msg="${options[num]} was ${choices[num]:+un}checked"
        [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"

        #remove break to allow multiple entries to be checked
        break
    done

    msg="nothing"
    for i in ${!options[@]}; do
        [[ "${choices[i]}" ]] && {
            msg="${options[i]}"
        }
    done

    if [[ $msg != "nothing" ]]; then
        performCheckout $msg
    else
        performCheckout ${options[0]}
    fi

else
    echoError "No $1 branch found!"
    if [[ $2 == "gdefaultbranchname" ]]; then
        performCheckout $(gdefaultbranchname)
    fi
fi
