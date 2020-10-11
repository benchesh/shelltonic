here=$PWD
source ~/.zxprofileLoader

#escape / and .
find=$(echo $(echo "$2" | sed -E 's/\//\\\//g') | sed -E 's/\./\\./g')
replace=$(echo $(echo "$3" | sed -E 's/\//\\\//g') | sed -E 's/\./\\./g')

echo "$1" | sed -E 's/'$find'/'$replace'/g'
