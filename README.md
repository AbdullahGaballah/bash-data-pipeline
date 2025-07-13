# bash-data-pipeline

A lightweight and fully logged Bash-based data pipeline that:

- Downloads a public CSV dataset  
- Cleans the data by removing empty or malformed rows  
- Performs basic analysis (record count, average height, and average weight)  
- Converts the cleaned CSV data into structured JSON format  
- Logs all steps with timestamps for traceability  

---

## 📁 Project Structure

bash-data-pipeline/
├── input/ # Raw downloaded CSV files
├── cleaned/ # Cleaned CSV output
├── reports/ # Analysis summary and JSON output
├── logs/ # Log files for each pipeline run
├── run_pipeline.sh # Main pipeline script
└── README.md # Project documentation

 

## 🚀 How to Run

Ensure the script is executable and run it from the project root:

 
chmod +x run_pipeline.sh
./run_pipeline.sh

## 📦 Output Files
input/data.csv – raw downloaded dataset

cleaned/cleaned_data.csv – cleaned version of the dataset

reports/summary.txt – statistical summary (record count, average height, weight)

reports/data.json – cleaned data in JSON format

logs/run.log – detailed execution log with timestamps

## 📊 Dataset Source
Florida State University - hw_200.csv

## 🛠️ Technologies Used
GNU Bash

awk for data processing

wget for file retrieval

Standard Unix tools (tail, mkdir, chmod, echo)

## 🧠 Author
Abdullah Mohammed – Data Engineer
www.linkedin.com/in/abdullahgab
