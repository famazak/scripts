#!/bin/bash
# Splits the csv file provided via the FILENAME argument
# into smaller files based on the number of lines included in the SPLIT_SIZE argument
# while preserving the header from the original file
# Stores split files in ./tmp directory and then zips them all up
FILENAME="$1"
SPLIT_SIZE=$2
HDR=$(head -1 "$FILENAME")
mkdir -p ./tmp
split -l $2 "$FILENAME" xyz
n=1
for f in xyz*
do
     if [ $n -gt 1 ]; then 
          echo $HDR > ./tmp/split_file_${n}.csv
     fi
     cat $f >> ./tmp/split_file_${n}.csv
     rm $f
     ((n++))
done
zip -r split_files.zip ./tmp