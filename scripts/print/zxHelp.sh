here=$PWD
source ~/.zxprofileLoader

cd "$zxprofileScriptsDirVar"
find . -type f -name "*.sh"
cd "$here"
