here=$PWD
source ~/.zprofileLoader

#deletes your LOCAL copy of a branch and replaces it with the remote version
git branch -d "$1"
gcheckout "$1"
