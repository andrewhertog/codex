#!/usr/bin/env bash

jsonfile=$(cat extensions.json)
extensions_dir=./vscode/extensions

count=$(jq -r '. | length' extensions.json)
for i in $(seq $count); do
  url=$(jq -r ".[$i-1].url" extensions.json)
  name=$(jq -r ".[$i-1].name" extensions.json)
  echo $name $url
  mkdir -p ${extensions_dir}/"$name"
  curl -L -o "$name".zip "$url"
  unzip "$name".zip -d ${extensions_dir}/"$name"
  mv ${extensions_dir}/"$name"/extension/* ${extensions_dir}/"$name"/
  rm "$name".zip
done
