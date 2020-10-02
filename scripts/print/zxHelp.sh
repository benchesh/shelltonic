here=$PWD
source ~/.zprofileLoader

cd "$(zprofileScriptsDir)"
find . -type f -name "*.sh"
cd "$here"
