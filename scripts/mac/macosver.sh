echo $(echo $(sw_vers -productVersion | cut -d '.' -f 1,2) | tr -d -c 0-9)
