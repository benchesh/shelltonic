here=$PWD
source ~/.zxprofileLoader

#get the git repo url
config=$(git config --get remote.origin.url)

#filter the url if it's not https (ie. git@github.com:org/reponame becomes https://github.com/org/reponame)
config=$(findAndReplace "${config%%.git}" git@ https://)
config=$(findAndReplace "$config" : /)
echo $(findAndReplace "$config" https/// https://)
