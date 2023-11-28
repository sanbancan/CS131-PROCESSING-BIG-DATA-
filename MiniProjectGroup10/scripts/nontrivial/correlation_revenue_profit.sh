#!/bin/bash

# Path to the CSV file
file_path="./data/Fortune 1000 Companies by Revenue.csv"

# Use Python to calculate the correlation
python3 - <<EOF
import pandas as pd
import numpy as np

# Function to convert currency strings to floats
def convert_currency(val):
    if val == '-':  # Check if the value is a dash, which indicates missing data
        return np.nan
    new_val = val.replace(',', '').replace('$', '').replace('(', '-').replace(')', '')
    try:
        return float(new_val)
    except ValueError:  # In case there are any other strings that cannot be converted
        return np.nan

# Read the CSV file
df = pd.read_csv("$file_path")

# Clean the column names by stripping whitespace
df.columns = df.columns.str.strip()

# Apply the conversion function to the revenues and profits columns
df['revenues'] = df['revenues'].apply(convert_currency)
df['profits'] = df['profits'].apply(convert_currency)

# Calculate the correlation, ignoring NaN values
correlation = df['revenues'].corr(df['profits'])
print(f"Correlation between Revenues and Profits: {correlation}")
EOF

#chmod +x ./scripts/nontrivial/correlation_revenue_profit.sh
#./scripts/nontrivial/correlation_revenue_profit.sh