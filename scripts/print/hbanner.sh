here=$PWD
source ~/.zprofileLoader

textSize=50
bannerOutput=$(banner -w$textSize "$*")

columns=$(tput cols)
while (($(echo "$bannerOutput" | wc -l) > $columns)); do
    textSize=$(($textSize - 1))
    bannerOutput=$(banner -w$textSize "$*")
done

columns=$(($columns / 2))
doubleChars=false
if (($(echo "$bannerOutput" | wc -l) < $columns)); then
    doubleChars=true
fi

SAVEIFS=$IFS
IFS=$'\n'

chars=""

startpoint=false

fillChar="%"

thisLine=""
for ((charNo = $textSize; charNo >= 0; charNo--)); do
    for line in $bannerOutput; do
        thisChar=${line:$charNo:1}
        addChar() {
            if [[ "$thisChar" == "#" ]]; then
                thisLine+="$fillChar"
                # thisLine+=$(randomChar "$fillChar")
            else
                thisLine+=" "
            fi
        }
        addChar
        if [ $doubleChars == true ]; then
            addChar
        fi
    done
    # if [ $startpoint == false ] && [[ $thisLine == *[$fillChar]* ]]; then
    if [ $startpoint == false ] && [[ $thisLine == *"$fillChar"* ]]; then
        startpoint=true
    fi

    if [ $startpoint == true ]; then
        thisLine+="\n"
    else
        thisLine=""
    fi

    # if [[ $thisLine == *[$fillChar]* ]]; then
    if [[ $thisLine == *"$fillChar"* ]]; then
        chars+=$thisLine
        thisLine=""
    fi
done
echo "\n"$chars

IFS=$SAVEIFS
