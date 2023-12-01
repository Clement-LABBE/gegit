#!/bin/bash

function init {
    if test -f data.json
    then
        echo "[Gegit] Data already exist. Are you sure you want to delete it? (y)"
        read -r resp
        test "$resp" = 'y' -o "$resp" = 'Y'  && printf '{ 
    "rep": []
}'> data.json && echo "Successfully reset data.json file." || echo "data.json file has not been deleted."
    else
        printf '{"rep": [] }'> data.json
        echo "Successfully created data.json file."
    fi
}

#add a new article identified by CODE with the description DESCRIPTION
#checks if the item is already in the item list, if not
#adds the item to the array
function add {
    name="$1"
    link="$2"
    test=$(jq --arg name "$name" '.rep | any(.name == $name)' data.json)
    if [ "$test" == true ]; then
        echo "[Gegit] Error : Depot ""$name"" already exists."
        exit 1;
    else
        jq --arg name "$name" --arg link "$link" '.rep += [{ "name": $name, "link": $link }]' data.json > temp.json
        mv temp.json data.json
    fi
    
}



#main content
#call the function corresponding to the argument
action="${1,,}"
shift
case $action in
        init) 
            init ;;
        add) 
            add "$@" ;;
        lend) 
            lend "$@";;
        retrieve) 
            retrieve "$@" ;;
        list)
            list "$@";;
        *)

            usage
            exit 1
    ;;
esac


exit 0