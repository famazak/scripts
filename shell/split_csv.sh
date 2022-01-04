#!/bin/bash

# Splits the csv file provided via the FILENAME argument
# into smaller files based on the number of lines included in the SPLIT_SIZE argument
# while preserving the header from the original file
# Stores split files in ./tmp directory and then zips them all up

# Usage (make sure the script is executable via chmod u+x):
# split_csv.sh FILENAME SPLIT_SIZE

# variable setup
FILENAME="$1"
SPLIT_SIZE=$2
CURRENT_TIME=$(date +%s)
TMP_DIR="tmp_${CURRENT_TIME}"
HDR=$(head -1 "$FILENAME")
LINES=$(< "$FILENAME" wc -l)
FILES=$((${LINES} / ${SPLIT_SIZE}))


mkdir -p ./${TMP_DIR}
echo "#### ${TMP_DIR} created"

echo "#### Splitting ${FILENAME} by ${SPLIT_SIZE} lines..."
echo "#### This operation will generate approximately ${FILES} file(s)"
split -l $2 "$FILENAME" xyz
n=1
for f in xyz*
do
     if [ $n -gt 1 ]; then 
          echo $HDR > ./${TMP_DIR}/split_file_${n}.csv
     fi
     cat $f >> ./${TMP_DIR}/split_file_${n}.csv
     rm $f
     ((n++))
done

echo "#### Zipping and cleaning up..."
zip -r split_files_${TMP_DIR}.zip ./${TMP_DIR}
rm -rf ./${TMP_DIR}

echo "#### ${FILENAME} successfully split by ${SPLIT_SIZE} lines and ${FILES} file(s) were created"
