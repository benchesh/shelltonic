here=$PWD
source ~/.zprofileLoader

git reset --mixed $(git rev-parse HEAD^)

gpushforce
