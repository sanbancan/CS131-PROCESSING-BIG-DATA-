#!/bin/bash

echo "Counting missing values for each column..."
awk -F, 'NR > 1 {
  for (i=1; i<=NF; i++) {
    if ($i ~ /^-$/ || $i ~ /^ *$/)
      missing[i]++;
  }
}
END {
  for (i in missing) {
    printf "Column %d: %d missing values\n", i, missing[i];
  }
}' "./data/Fortune 1000 Companies by Revenue.csv"

#./scripts/metadata/missing_values.sh