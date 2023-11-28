#!/bin/bash

# Volatility: Standard Deviation of Revenue and Profit Percent Change
awk -F, '
NR > 1 {
  # Remove commas, dollar signs, percentage signs, and quotes
  gsub(/[$"%,"]/, "", $4);
  revenue_changes[NR] = $4;
  sum_revenue += $4;
  
  gsub(/[$"%,"]/, "", $6);
  profit_changes[NR] = $6;
  sum_profit += $6;
  
  count++;
}
END {
  mean_revenue = sum_revenue/count;
  mean_profit = sum_profit/count;
  
  for (i in revenue_changes) {
    sum_sq_rev += ((revenue_changes[i] - mean_revenue) ** 2);
    sum_sq_prof += ((profit_changes[i] - mean_profit) ** 2);
  }
  
  volatility_revenue = sqrt(sum_sq_rev/count);
  volatility_profit = sqrt(sum_sq_prof/count);
  
  print "Revenue Change Volatility: " volatility_revenue;
  print "Profit Change Volatility: " volatility_profit;
}' "./data/Fortune 1000 Companies by Revenue.csv"

#sed -i -e 's/\r$//' ./scripts/volatility.sh
#./scripts/volatility.sh