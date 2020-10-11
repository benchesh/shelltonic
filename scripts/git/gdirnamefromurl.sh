here=$PWD
source ~/.zxprofileLoader

repo=${1/*\//}
repo=${repo%%.*}
echo ${repo}
