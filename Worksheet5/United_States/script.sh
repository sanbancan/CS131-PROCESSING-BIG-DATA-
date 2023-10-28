#!/bin/bash



for CATEGORY in "$@"; do

    # Create the category directory if it doesn't exist
    touch "$CATEGORY.txt"

    while IFS= read -r line; do
        IFS=, read -ra arr <<< "$line"

        if [[ "${arr[4]}" == "$CATEGORY" && "${arr[7]}" == "United States" ]]; then
            echo "$line" >> "$CATEGORY.txt"
        fi
    done < dataset.csv

    echo "$CATEGORY: $(wc -l < "$CATEGORY.txt")" >> Worksheet5.txt
done
