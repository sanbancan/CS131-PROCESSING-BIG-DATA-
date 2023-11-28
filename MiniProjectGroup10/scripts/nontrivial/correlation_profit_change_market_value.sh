#!/bin/bash

# Path to the CSV file
file_path="./data/Fortune 1000 Companies by Revenue.csv"

# Use Python to calculate the correlation
python3 - <<EOF
import pandas as pd

df = pd.read_csv("$file_path")
# Replace non-numeric strings with NaN and convert the column to floats
df['profits_percent_change'] = pd.to_numeric(df['profits_percent_change'].replace('[\%,]', '', regex=True), errors='coerce')
df['market_value '] = pd.to_numeric(df['market_value '].replace('[\$,]', '', regex=True), errors='coerce')

# Calculate the correlation, ignoring NaN values
correlation = df['profits_percent_change'].corr(df['market_value '])
print(f"Correlation between Profits Percent Change and Market Value: {correlation}")
EOF

#chmod +x ./scripts/nontrivial/correlation_profit_change_market_value.sh
#./scripts/nontrivial/correlation_profit_change_market_value.sh