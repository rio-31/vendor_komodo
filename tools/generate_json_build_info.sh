#!/bin/sh
if [ "$1" ]
then
  file_path=$1
  file_name=$(basename "$file_path")
  if [ -f $file_path ]; then
    file_size=$(stat --printf="%s" "$file_path")
    md5=$(cat "$file_path.md5sum" | cut -d' ' -f1)
    datetime=$(grep ro\.build\.date\.utc $OUT/system/build.prop | cut -d= -f2);
    id=$(sha256sum $file_path | awk '{ print $1 }');
    echo "{" > $file_path.json
    echo "  \"error\"       : false," >> $file_path.json
    echo "  \"id\"          : \"$id\"," >> $file_path.json
    echo "  \"filename\"    : \"$file_name\"," >> $file_path.json
    echo "  \"datetime\"    : $datetime," >> $file_path.json
    echo "  \"version\"     : \"2.5\"," >> $file_path.json
    echo "  \"size\"        : $file_size," >> $file_path.json
    echo "  \"filehash\"    : \"$md5\"," >> $file_path.json
    echo "  \"website_url\" : \"https://komodo-os.my.id\"," >> $file_path.json
    echo "  \"news_url\"    : \"https://t.me/KomodOSRom\"," >> $file_path.json
    echo "  \"donate_url\"  : \"https://www.paypal.me/KomodoOS\"," >> $file_path.json
    echo "  \"maintainer\"  : \"\"," >> $file_path.json
    echo "  \"maintainer_url\" : \"https://github.com/\"," >> $file_path.json
    echo "  \"forum_url\"      : \"https://t.me/KomodOSGroup\"," >> $file_path.json
    echo "}" >> $file_path.json
  fi
fi
