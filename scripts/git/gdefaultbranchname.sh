here=$PWD
source ~/.zprofileLoader

echo $(basename $(git symbolic-ref --short refs/remotes/origin/HEAD))
