here=$PWD
source ~/.zprofileLoader

if [[ $(isAdmin) == false ]]; then
    echo "mas install skipped!"
else
    #update the app lists with the 'mas list' cmd then do regex to replace spaces with underscores
    bigApps=(
        497799835_Xcode
        823766827_OneDrive
        784801555_Microsoft_OneNote
        462054704_Microsoft_Word
        462058435_Microsoft_Excel
        985367838_Microsoft_Outlook
        462062816_Microsoft_PowerPoint
        408981434_iMovie
        682658836_GarageBand
        634148309_Logic_Pro_X
        424389933_Final_Cut_Pro
        634159523_MainStage_3
        434290957_Motion
        424390742_Compressor
        409183694_Keynote
        409201541_Pages
        409203825_Numbers
        824183456_Affinity_Photo
        824171161_Affinity_Designer
    )

    apps=(
        425424353_The_Unarchiver
        731859284_Any_File_Info
        449830122_HyperDock
        568494494_Pocket
        1147396723_WhatsApp
        1480068668_Messenger
        803453959_Slack
        890805912_Newsflow
        1120214373_Battery_Health_2
        447726582_com.etinysoft.iAudioConverter
        414209656_Better_Rename_9
        1482454543_Twitter
        404009241_BBEdit
        1368687270_Kingpin_Private_Browser
        1153157709_Speedtest
        1025306797_Resize_Master
        1176895641_Spark
        641027709_Color_Picker
        1171894796_Open_Directory_in_Terminal
        816042486_Compare_Folders
        1458095236_FileZilla
        523620159_CleanMyDrive_2
        1044549675_Elmedia_Video_Player
        1356686763_Vimeo
        1114922065_WeTransfer
        863486266_SketchBook
        979299240_Network_Kit_X
        1335612105_MKPlayer
        419332741_XMenu
        1054607607_Helium
        1018899653_HeliumLift
        1042548577_Image2Vector
        1196139678_TransparentGIF
        880663569_Autodesk_Pixlr
        514951692_NetSpot
        430255202_Mactracker
        1423715984_EtreCheck
        995838410_Browser_Ninja
        1184398109_Fleet
        897118787_Shazam
        426654691_Total_Video_Converter_Pro
        937984704_Amphetamine
        928940999_PasteBox
        446243721_Disk_Space_Analyzer
        1438772273_Cinebench
        1438287690_ZipMounter_Lite
        405399194_Kindle
        508368068_com.alice.mac.GetPlainText
        425264550_Disk_Speed_Test
        1278508951_Trello
    )

    #install (unofficial) mac app store cli (only works on mac os 10.14 and above)
    masList=$(mas list)
    if (($(macosver) > 1013)); then
        if [[ $masList == "" ]]; then
            brew install mas
            masList=$(mas list)
        else
            brew upgrade mas
        fi
    fi

    #add all apps to apps list (comment out to only install the smaller apps)
    apps=("${bigApps[@]}" "${apps[@]}")

    #install mac app store apps if mas is installed successfully
    if [[ $masList != "" ]]; then
        for entry in ${apps[@]}; do
            entryBeforeUnderscore=$(echo $entry | cut -d _ -f 1)
            if [[ "$masList" != *$entryBeforeUnderscore* ]]; then
                echo "$entry will be installed"
                mas install $entryBeforeUnderscore
            fi
        done
    fi

fi
