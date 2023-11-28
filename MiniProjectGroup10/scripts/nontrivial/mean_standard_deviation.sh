#!/bin/bash

# Path to the CSV file
file_path="./data/Fortune 1000 Companies by Revenue.csv"

# Use Python to calculate mean and standard deviation
python3 - <<EOF
import pandas as pd
import numpy as np

# Function to convert strings with commas and potential negative signs to float
def convert_to_float(val):
    if isinstance(val, str):
        val = val.replace(',', '').replace('$', '').replace('(', '-').replace(')', '')
        if val.strip() == '-' or val.strip() == '':
            return np.nan  # Convert missing value indicators to NaN
        try:
            return float(val)
        except ValueError:
            return np.nan  # Convert other non-numeric strings to NaN
    return val

# Convert percentage strings to floats
def convert_percentage(val):
    if isinstance(val, str):
        val = val.replace('%', '').replace('(', '-').replace(')', '')
        if val.strip() == '-' or val.strip() == '':
            return np.nan
        try:
            return float(val) / 100
        except ValueError:
            return np.nan
    return val

# Read the CSV file
df = pd.read_csv("$file_path")

# Clean the columns and convert to float
df['revenues '] = df['revenues '].apply(convert_to_float)
df['profits '] = df['profits '].apply(convert_to_float)
df['revenue_percent_change'] = df['revenue_percent_change'].apply(convert_percentage)
df['profits_percent_change'] = df['profits_percent_change'].apply(convert_percentage)
df['assets'] = df['assets'].apply(convert_to_float)
df['market_value '] = df['market_value '].apply(convert_to_float)
df['change_in_rank'] = pd.to_numeric(df['change_in_rank'], errors='coerce')  # Convert directly, handling errors
df['employees '] = pd.to_numeric(df['employees '].str.replace(',', ''), errors='coerce')  # Remove commas and convert

# Handle missing values in 'change_in_rank'
df['change_in_rank'] = pd.to_numeric(df['change_in_rank'].replace('-', np.nan), errors='coerce')

# Calculate the mean and standard deviation for each column
means = df[['revenues ', 'profits ', 'revenue_percent_change', 'profits_percent_change', 
            'assets', 'market_value ', 'change_in_rank', 'employees ']].mean()
std_devs = df[['revenues ', 'profits ', 'revenue_percent_change', 'profits_percent_change', 
               'assets', 'market_value ', 'change_in_rank', 'employees ']].std()

# Print out the results
print("Means and Standard Deviations:")
print(means)
print(std_devs)
EOF

#./scripts/nontrivial/mean_standard_deviation.sh