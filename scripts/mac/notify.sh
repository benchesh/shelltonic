osascript -e "display notification \"$*\" with title \"$(basename "$PWD")\""
echo "$*"
