here=$PWD
source ~/.zprofileLoader

if [[ -f yarn.lock ]]; then
    echo "Running tests..."
    yarn test
    echo "Running lint..."
    yarn lint --fix
    gstatus
fi
