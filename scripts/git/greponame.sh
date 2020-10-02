here=$PWD
source ~/.zprofileLoader

echo $(basename "$(git rev-parse --show-toplevel)")
