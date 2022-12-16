#!/usr/bin/env bash

# wrapper script to help make it easier generating dbt model yaml(s) from dbt-codegen package

scriptname=$0

function timestamp() {
    date +"%Y-%m-%d_%H-%M-%S" # current time
}

function usage {
    echo "usage: $scriptname [-h] [-f file] [model(s)]"
    echo " -h:              display help"
    echo " -f:              specify file to APPEND dbt model yaml to.  Will create if it doesn't exist"
    echo " model(s):        name(s) of dbt models to generate yaml for"
    echo " Ex: $scriptname -f schema.yml model_1_name model_n_name"
    exit 1
}

# exit and print help if no params provided
if [ $# -eq 0 ] ;
then
    echo "$scriptname expects parameters."
    usage
    exit 0
fi

while getopts "hf:" opt; do
    case $opt in
        h)
            usage;;
        f) 
            echo "$(timestamp): -f was triggered with $OPTARG" >&2
            file=$OPTARG;;
        \?) 
            exit 42;; # exit if bad param provided
    esac
done

# shift from options to positional args
shift $((OPTIND - 1))

# iterate through positional args, run dbt command and append model yaml to $file
for var in "$@"
do
    if [ -e "$file" ] && grep -q "models:" "$file"
    then
        # if $file exists already and already contains "models:", 
        # append dbt output without top-level models key and dbt output log lines (they start with numbers)
        dbt run-operation generate_model_yaml --args '{"model_name": '$var'}' | awk '!/^[0-9]|models/' >> "$file"
        echo "$(timestamp): Model yaml for '$var' appended to '$file'"
    else
        # if $file doesn't exist yet, write & append everything from the dbt output to $file
        # except the log lines that start with numbers as these are not part of the model yaml
        dbt run-operation generate_model_yaml --args '{"model_name": '$var'}' | awk '!/^[0-9]/' >> "$file"
        echo "$(timestamp): Creating file '$file' and appending model yaml for '$var'"
    fi
done
