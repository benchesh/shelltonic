here=$PWD
source ~/.zprofileLoader

# while read -n 1 byte; do
#     ord=$(printf "%b" "${byte:-\000}" |
#         od -t x1 |
#         {
#             read offset hex
#             echo $hex
#         })
#     echo "$ord"
# done <"$*"

xxd -p "$*" | tr -d '\n'
echo ""
