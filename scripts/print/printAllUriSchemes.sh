here=$PWD
source ~/.zxprofileLoader

SAVEIFS=$IFS                                                                                                                                          # Save current IFS
IFS=$'\n' read -d '' -r -a arr <<<"$(/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -dump)" # Convert string to array
IFS=$SAVEIFS                                                                                                                                          # Restore IFS

outputArr=()
for item in "${arr[@]}"; do
	binding=${item#*:}
	if [[ $item == *"bindings:"* ]] && [[ $binding == *":"* ]]; then
		outputArr=("${outputArr[@]}" $(echo $binding | sed -e 's/,//g'))
	fi
done

#remove duplicate lines
outputArr=($(echo "${outputArr[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

#print array
printf '%s\n' "${outputArr[@]}"
