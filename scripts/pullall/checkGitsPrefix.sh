here=$PWD
source ~/.zprofileLoader

cd "$(zprofileConfigDir)"

if [[ -f "checkGits-prefix.txt" ]]; then
    echo ~/"$(cat "checkGits-prefix.txt")/"
else
    echo ~
fi
