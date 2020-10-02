if [[ "$(echo "$1" | tr '[:upper:]' '[:lower:]')" == *"$(echo "$2" | tr '[:upper:]' '[:lower:]')"* ]]; then
    echo true
else
    echo false
fi
