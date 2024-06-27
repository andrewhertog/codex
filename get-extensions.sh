#!/usr/bin/env bash

#jsonfile=$(wget -O - https://raw.githubusercontent.com/vipinpaul/oak-extensions/main/extensions.json)
jsonfile=$(cat extensions.json)

#cd vscode/

count=$(jq -r '. | length' extensions.json)
for i in $(seq $count); do
  url=$(jq -r ".[$i-1].url" extensions.json)
  name=$(jq -r ".[$i-1].name" extensions.json)
  echo $name $url
  mkdir -p ./extensions/"$name"
  wget "$url" -O "$name".zip
  unzip "$name".zip -d ./extensions/"$name"
  mv ./extensions/"$name"/extension/* ./extensions/"$name"/
  rm "$name".zip
done
