cd "$(dirname "$0")"
sh "$(find . -iname "compileZprofile.sh" -print -quit)"
source ".zprofileCompiled"
endProcess
