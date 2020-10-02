here=$PWD
source ~/.zprofileLoader

if [[ -f package.json ]]; then
    if [[ $* == *"nonpm"* ]]; then
        echo "nonpm: package.json in $here will not be installed!"
    else
        if cmdExists node; then
            echo "Installing package.json in $here"
            if [[ -f yarn.lock ]]; then
                echo "checking yarn..."

                if [[ $* == *"cacheclean"* ]]; then
                    yarn cache clean
                fi

                yarn install --frozen-lockfile
            else
                echo "checking npm..."

                if [[ $* == *"updatenpm"* ]]; then
                    echo "updating npm..."

                    npm update

                    git commit -o package.json -m "Auto pkg dependency updates"
                    gpush skippull
                elif [[ -f "package-lock.json" ]]; then
                    npm ci
                else
                    echoWarning "package-lock.json not found! To add a new lockfile, run checkPkg updatenpm"
                fi
            fi
        else
            echoWarning "npm is not installed"
        fi
    fi
fi
