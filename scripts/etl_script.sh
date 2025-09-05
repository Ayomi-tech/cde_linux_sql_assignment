#!/bin/bash
mkdir Transformed Gold
echo raw Transformed Gold

#Defining Directories
raw_dir="/Users/makpro/Desktop/raw"
transformed_dir="/Users/makpro/Desktop/Transformed"
gold_dir="/Users/makpro/Desktop/Gold"

#Confirm the created folders
echo "$raw_dir" "$transformed_dir" "$gold_dir"

#Confirm the downloaded csv file from raw folder
if [ -f "$raw_dir/annual-enterprise-survey-2023-financial-year-provisional.csv" ]; then echo "Congratulations, file found"
else echo "Sorry, file not found"
exit 1
fi

#Renaming field Variable_code to variable_code
sed -i '' 's/Variable_code/variable_code/' "$raw_dir/annual-enterprise-survey-2023-financial-year-provisional.csv"

#Confirming the changed field's name
awk 'NR==1 {print; exit}' "$raw_dir/annual-enterprise-survey-2023-financial-year-provisional.csv"

#Selecting and saving the selected columns to 2023_year_finance.csv
csvcut -c Year,Value,Units,variable_code "$raw_dir/annual-enterprise-survey-2023-financial-year-provisional.csv" > "$raw_dir/2023_year_finance.csv"


#Moving the saved 2023_year_finance.csv to Transformed folder
mv "$raw_dir/2023_year_finance.csv" "$transformed_dir/"

#Confirming the movement of 2023_year_finance.csv to Transformed folder
if [ -f "$transformed_dir/2023_year_finance.csv" ]; then echo "Good job, file found in transformed"
else echo "Sorry, file not found in transformed"
exit 1
fi

#Moving transformed file to Gold folder
echo "Moving transformed file to Gold folder"
cp "$transformed_dir/2023_year_finance.csv" "$gold_dir/"

if [ -f "$gold_dir/2023_year_finance.csv" ]; then echo "File successfully loaded to Gold folder"
else echo "Failed to load file to Gold folder"
exit 1
fi

echo "----------ETL PROCESS COMPLETED----------"
