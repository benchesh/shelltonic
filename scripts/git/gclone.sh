here=$PWD
source ~/.zprofileLoader

repo=$(gdirnamefromurl $1)
echo $repo
hbanner ${repo}

while [ ! -d ${repo} ]; do
    printlines
    echo "Cloning $1"
    git clone "$1"
    sleep 1
done
