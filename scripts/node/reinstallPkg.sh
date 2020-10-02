here=$PWD
source ~/.zprofileLoader

trash node_modules
checkPkgInAllDirs $@
notify Node modules reinstalled
