#!/bin/bash

# Define directories
input_dir="./input"
cleaned_dir="./cleaned"
log_dir="./logs"
report_dir="./reports"

# Create required directories
mkdir -p "$input_dir" "$cleaned_dir" "$log_dir" "$report_dir"

# Define file paths
log_file="$log_dir/run.log"
input_file="$input_dir/data.csv"
cleaned_file="$cleaned_dir/cleaned_data.csv"
summary_file="$report_dir/summary.txt"
json_file="$report_dir/data.json"

# Start pipeline log
echo "[$(date)] Starting pipeline..." >> "$log_file"

# Data source URL
data_url="https://people.sc.fsu.edu/~jburkardt/data/csv/hw_200.csv"
echo "[$(date)] Downloading data from $data_url" >> "$log_file"

wget -q -O "$input_file" "$data_url"

if [ $? -eq 0 ]; then
    echo "[$(date)] Data downloaded successfully." >> "$log_file"
else
    echo "[$(date)] Failed to download data." >> "$log_file"
    exit 1
fi

echo "[$(date)] Cleaning data..." >> "$log_file"
awk 'NF' "$input_file" > "$cleaned_file"

if [ $? -eq 0 ]; then
    echo "[$(date)] Data cleaned successfully." >> "$log_file"
else
    echo "[$(date)] Failed to clean data." >> "$log_file"
    exit 1
fi

echo "[$(date)] Starting data analysis..." >> "$log_file"

tail -n +2 "$cleaned_file" | awk -F',' '
{
    height += $2;
    weight += $3;
    count++;
}
END {
    if (count > 0) {
        printf "Record count: %d\nAverage height: %.2f\nAverage weight: %.2f\n", count, height/count, weight/count;
    } else {
        print "No data to analyze";
    }
}' > "$summary_file"

if [ $? -eq 0 ]; then
    echo "[$(date)] Data analysis saved to $summary_file" >> "$log_file"
else
    echo "[$(date)] Data analysis failed" >> "$log_file"
    exit 1
fi

echo "[$(date)] Starting CSV to JSON conversion..." >> "$log_file"

{
    echo "["
    total_lines=$(wc -l < "$cleaned_file")
    total_data_lines=$((total_lines - 1))
    line_num=0
    tail -n +2 "$cleaned_file" | awk -F',' -v total="$total_data_lines" '
    {
        printf "  {\"Index\": %s, \"Height\": %s, \"Weight\": %s}", $1, $2, $3;
        line_num++
        if (line_num < total) {
            printf ",\n"
        } else {
            printf "\n"
        }
    }'
    echo "]"
} > "$json_file"

if [ $? -eq 0 ]; then
    echo "[$(date)] JSON file saved to $json_file" >> "$log_file"
else
    echo "[$(date)] JSON conversion failed" >> "$log_file"
    exit 1
fi
