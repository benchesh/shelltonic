here=$PWD
source ~/.zxprofileLoader

git reset --mixed $(git rev-parse HEAD^)

gpushforce
