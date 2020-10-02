here=$PWD
source ~/.zprofileLoader

repo=${1/*\//}
repo=${repo%%.*}
echo ${repo}
