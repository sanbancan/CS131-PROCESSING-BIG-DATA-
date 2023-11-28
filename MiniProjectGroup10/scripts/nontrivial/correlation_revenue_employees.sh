#!/bin/bash

# Path to the CSV file, assuming the script is run from the MiniProjectGroup10 directory
file_path="data/Fortune 1000 Companies by Revenue.csv"

# Use Python to calculate the correlation
python3 - <<EOF
import pandas as pd

df = pd.read_csv("$file_path")

df['revenues '] = pd.to_numeric(df['revenues '].str.replace('[\$,]', '', regex=True), errors='coerce')
df['employees '] = pd.to_numeric(df['employees '].str.replace('[\$,]', '', regex=True), errors='coerce')

correlation = df['revenues '].corr(df['employees '])
print(f"Correlation between Revenues and Employees: {correlation}")
EOF

#chmod +x ./scripts/nontrivial/correlation_revenue_employees.sh
#./scripts/nontrivial/correlation_revenue_employees.sh