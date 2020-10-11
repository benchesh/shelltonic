here=$PWD
source ~/.zxprofileLoader

#install brew stuff
printlines
echo "Checking homebrew..."

if [[ $(isAdmin) == false ]]; then
    echo "Homebrew updates skipped!"
else
    #get homebrew
    if ! cmdExists brew; then
        notify Installing homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    #needed for grunt-image-resize
    if cmdExists convert; then
        brew install imagemagick
    else
        brew upgrade imagemagick
    fi

    #ffmpeg
    if cmdExists ffmpeg; then
        brew install ffmpeg
    else
        brew upgrade ffmpeg
    fi
fi
