#!/bin/bash
# Count the total number of entries in the CSV, subtracting the header row
entries=$(wc -l "./data/Fortune 1000 Companies by Revenue.csv" | cut -d' ' -f1)
echo "Total entries: $((entries - 1))"

#Run these two commands
#chmod +x scripts/count_entries.sh
#./scripts/metadata/count_entries.sh