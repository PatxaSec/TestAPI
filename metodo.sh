#!/bin/bash

redColour="\e[0;31m\033[1m"
endColour="\033[0m\e[0m"
greenColour="\e[0;32m\033[1m"
yellowColour="\e[0;33m\033[1m"

URL=$1
ENDPOINTS=$(cat $2)
v=$3

API_Scan() {
    local URL=$1
    for end in $ENDPOINTS; do
        FULL="${URL}${end}"
        for metodo in GET POST OPTIONS HEAD PUT DELETE TRACE PATCH; do
            RESPONSE=$(curl -kis -X $metodo "${FULL}" -H "accept: application/ld+json" | head -n 1 | awk '{print $2}')
            if [[ $RESPONSE == 200 ]]; then
                printf "${greenColour}[+] ${end} -> ${metodo} -> ${FULL} ${endColour}\n"
            elif [[ $RESPONSE == 401 ]]; then
                printf "${yellowColour}[!] ${end} -> ${metodo} -> [401] Bearer needed ${endColour}\n"
            else
                if [[ -n "$v" ]]; then
                    printf "${redColour}[!] ${end} -> ${metodo} -> [${RESPONSE}] ${endColour}\n"
                fi
            fi
        done
    done
}

if [ -f "$1" ]; then
    for i in $(cat targets); do
        echo "===================================================================>>>>" $i
        API_Scan $i
    done
else
    echo "===================================================================>>>>" $1
    API_Scan $1
fi
