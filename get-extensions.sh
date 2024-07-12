#!/usr/bin/env bash

jsonfile=$(cat extensions.json)
extensions_dir=./vscode/extensions
base_dir=$(pwd)

count=$(jq -r '. | length' extensions.json)
for i in $(seq $count); do
  url=$(jq -r ".[$i-1].url" extensions.json)
  name=$(jq -r ".[$i-1].name" extensions.json)
  echo $name $url
  mkdir -p ${extensions_dir}/"$name"
  curl -L -o "$name".zip "$url"
  unzip "$name".zip -d ${extensions_dir}/"$name"
  mv ${extensions_dir}/"$name"/extension/* ${extensions_dir}/"$name"/
  cd ${extensions_dir}/"$name"
  if [ -d "node_modules" ]; then
    rm -rf node_modules
    npm install --omit=dev
  fi
  if [ -d "out" ]; then
    rm -rf out
  fi
  cd ${base_dir}
  rm "$name".zip
done
