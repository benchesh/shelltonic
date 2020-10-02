var="$*"
echo "${var:$((RANDOM % ${#var})):1}" # pick a 1 char substring starting at a random position
