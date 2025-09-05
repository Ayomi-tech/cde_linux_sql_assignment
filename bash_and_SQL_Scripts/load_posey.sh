#!/bin/bash

source_dir="/Users/makpro/Desktop/raw/parchposey-master/data-raw"
db_name="posey"
db_user="$USER"

#Ensure database exists
createdb -U "$db_user" "$db_name" 2>/dev/null || echo "Database $db_name already exists."

for file in "$source_dir"/*.csv; do
    [ -e "$file" ] || continue

    filename=$(basename "$file")
    table_name="${filename%.csv}"

    echo "📂 Processing $filename → table: $table_name"

    # Read header row (comma-separated column names)
    header=$(head -n 1 "$file")
    IFS=',' read -ra columns <<< "$header"

    #CREATE TABLE statement
    create_stmt="CREATE TABLE IF NOT EXISTS $table_name ("
    for col in "${columns[@]}"; do
        clean_col=$(echo "$col" | tr -d '"' | tr '[:upper:]' '[:lower:]' | tr -s ' ' '_' )
        create_stmt+="$clean_col TEXT, "
    done
    create_stmt=${create_stmt%, } # remove trailing comma
    create_stmt+=");"

    #Create table
    psql -U "$db_user" -d "$db_name" -c "$create_stmt"

    #Import CSV data
    psql -U "$db_user" -d "$db_name" -c "\copy $table_name FROM '$file' CSV HEADER;"

    echo "✅ Loaded $filename into $table_name"
done

echo "🎉 All CSVs processed into database: $db_name"

