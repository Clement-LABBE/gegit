#!/bin/bash

function init {
    if test -f data.json
    then
        echo "[pret.sh] Data already exist. Are you sure you want to delete it? (y)"
        read -r resp
        test "$resp" = 'y' -o "$resp" = 'Y'  && printf '{ 
    "rep": []
}'> data.json && echo "Successfully reset data.json file." || echo "data.json file has not been deleted."
    else
        printf '{"rep": [] }'> data.json
        echo "Successfully created data.json file."
    fi
}

function