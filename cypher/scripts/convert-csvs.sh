#!/bin/bash

set -e
set -o pipefail

echo "Starting preprocessing CSV files"

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

: ${NEO4J_CSV_DATA_DIR:?"Environment variable NEO4J_CSV_DATA_DIR is unset or empty"}
: ${NEO4J_CSV_POSTFIX:?"Environment variable NEO4J_CSV_POSTFIX is unset or empty"}

# provide progressbar is available
if command -v pv > /dev/null 2>&1; then
  SNB_CAT=pv
else
  SNB_CAT=cat
fi

# replace headers
while read line; do
  IFS=' ' read -r -a array <<< $line
  FILENAME=${array[0]}
  HEADER=${array[1]}

  echo ${FILENAME}: ${HEADER}
  # replace header (no point using sed to save space as it creates a temporary file as well)
  echo ${HEADER} | ${SNB_CAT} - <(tail -n +2 ${$NEO4J_CSV_DATA_DIR}/${FILENAME}${NEO4J_CSV_POSTFIX}) > tmpfile.csv && mv tmpfile.csv ${$NEO4J_CSV_DATA_DIR}/${FILENAME}${NEO4J_CSV_POSTFIX}
done < headers.txt

echo "Finished preprocessing CSV files"
