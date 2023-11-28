#!/bin/bash

echo "Inferring data types for each column..."
awk -F, 'NR==2 {
  for (i=1; i<=NF; i++) {
    if ($i ~ /^[+-]?[0-9]+$/) 
      printf "Column %d: Integer\n", i;
    else if ($i ~ /^[+-]?[0-9]+(\.[0-9]+)?$/) 
      printf "Column %d: Float\n", i;
    else 
      printf "Column %d: String\n", i;
  }
}' "./data/Fortune 1000 Companies by Revenue.csv"

#./scripts/metadata/data_types.sh