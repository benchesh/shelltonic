here=$PWD
source ~/.zxprofileLoader

cd "$(zxprofileConfigDir)"

if [[ -f "checkGits-prefix.txt" ]]; then
    echo ~/"$(cat "checkGits-prefix.txt")/"
else
    echo ~
fi
