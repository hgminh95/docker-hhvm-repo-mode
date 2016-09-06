#!/bin/bash

>&2 echo "Compile php code ...!"

touch /var/run/hhvm/fileindex

INDEX_TMP="/var/run/hhvm/fileindex"

find $PHP_SRC_ROOT -name \*.php > $INDEX_TMP

hhvm --hphp -t hhbc --input-list $INDEX_TMP --output-dir /var/run/hhvm/

>&2 echo "Clear file content"
while read -u 10 p; do
  truncate -s 0 $p
done 10<$INDEX_TMP

exec "$@"
