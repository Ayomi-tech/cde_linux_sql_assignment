#!/bin/bash

#Define directories
source_dir='/Users/makpro/Desktop/csv_json_main'
destination_dir='/Users/makpro/Desktop/csv_json_loaded'

#Confirm the created directories
echo "$source_dir" "$destination_dir"

#List all files in source dir
files=$(ls "$source_dir")
moved=false

#Loading csv and json files to destination_dir
for file in $files; do
if [[ "$file"==*.csv || "$file"==*.json ]]; then
	mv "$source_dir/$file" "$destination_dir/"
	echo "File moved successfully"
	moved=True
fi
done

if [ "$moved"=false ]; then
	echo "No CSV or JSON file availabe in source_dir"

echo "--------Extracted and Loaded file successful--------"