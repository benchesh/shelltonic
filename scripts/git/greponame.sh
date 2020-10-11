here=$PWD
source ~/.zxprofileLoader

echo $(basename "$(git rev-parse --show-toplevel)")
