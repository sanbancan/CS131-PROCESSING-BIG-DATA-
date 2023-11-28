#!/bin/bash
# Print min and max values for a specified column number
column=$1
min=$(cut -d',' -f$column "./data/Fortune 1000 Companies by Revenue.csv" | sed '1d' | tr -d '"' | sed 's/\$//g' | tr -d ',' | sort -n | head -1)
max=$(cut -d',' -f$column "./data/Fortune 1000 Companies by Revenue.csv" | sed '1d' | tr -d '"' | sed 's/\$//g' | tr -d ',' | sort -n | tail -1)
echo "Column $column: Min value is $min, Max value is $max"

#Run ./scripts/metadata/value_ranges.sh 2
#Change the last number to the column you want to extract