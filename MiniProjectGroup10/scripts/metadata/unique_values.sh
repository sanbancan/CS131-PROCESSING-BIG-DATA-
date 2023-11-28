#!/bin/bash

echo "Counting unique values for each column..."
for i in $(seq 1 $(head -1 "./data/Fortune 1000 Companies by Revenue.csv" | grep -o "," | wc -l)); do
  echo "Column $i:"
  cut -d, -f$i "./data/Fortune 1000 Companies by Revenue.csv" | sort | uniq | wc -l
done

#./scripts/metadata/unique_values.sh