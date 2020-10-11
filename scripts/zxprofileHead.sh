# disable annoying permissions issue
ZSH_DISABLE_COMPFIX=true

if [[ "$zxprofileScriptsDirVar" == "" ]]; then
	zxprofileScriptsDirVar="$(dirname "$0")/"
fi

zxprofileDir() {
	echo "$(dirname "$zxprofileScriptsDirVar")/"
}

zxprofileConfigDir() {
	echo "$(zxprofileDir)config/"
}

endProcess() {
	kill -INT $$
}

mkdirGo() {
	mkdir -p "$*"
	cd "$*"
}

findZXProfileScript() {
	cd "$zxprofileScriptsDirVar"
	filepath=$(find . -iname "$1.sh" -print -quit)
	if [ $filepath ]; then
		echo "$zxprofileScriptsDirVar${filepath#./}"
	fi
}

command_not_found_handler() {
	currentDir=$PWD
	if [[ "$zxprofileScriptsDirVar" != *"ERROR:"* ]]; then
		filepath="$(findZXProfileScript $1)"
		cd $currentDir

		if [ $filepath ]; then
			sh "$filepath" ${@:2}
		else
			args="${@:2}"
			if [[ "$args" != "" ]]; then
				args=" with args: $args"
			fi
			sh "$(findZXProfileScript echoError)" "command_not_found_handler: you tried to run $1$args"
		fi
	else
		zxprofileDir
	fi
}
