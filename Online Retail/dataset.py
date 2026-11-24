import pandas as pd
import os
from dotenv import load_dotenv
import psycopg2
import tempfile

# Read all tabs from the Excel file into a DataFrame
excel_file = 'online+retail+ii/online_retail_II.xlsx'
sheets = pd.read_excel(excel_file, sheet_name=None)
df = pd.concat(sheets.values(), ignore_index=True)
print(df.head())

#Check the shape of the DataFrame
print(df.shape) # 1067371 rows, 8 columns

# # Check the columns of the DataFrame
print(df.columns)

# Check the data types of the columns
print(df.dtypes)

# Load the environment variables from the .env file
load_dotenv()

# Load the database connection parameters from the environment variables
db_host = os.getenv('DB_HOST')
db_name = os.getenv('DB_NAME')
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')
db_port = os.getenv('DB_PORT')

# Load the data into a PostgreSQL database
conn = psycopg2.connect(
    host=db_host,
    database=db_name,
    user=db_user,
    password=db_password,
    port=db_port
)

curr = conn.cursor()

# In order to load the data into a PostgreSQL database, we are going to use copy_expert
# We will first create a temp file to hold the data in CSV format, so we need to import tempfile

# This is the SQL command to copy the data from the temp file into the staging.raw_data table
copy_sql = r"""
    COPY staging.raw_data (
    invoice, stock_code, description, quantity, invoice_date, price, customer_id, country)
    FROM STDIN WITH (FORMAT CSV, NULL '\N')
"""

# This list is used to specify the order of the columns in the DataFrame when writing to the temp file
source_columns = ['Invoice', 'StockCode', 'Description', 'Quantity', 'InvoiceDate', 'Price', 'Customer ID', 'Country']

# This code block creates a temporary file, writes the DataFrame to it in CSV format, and then uses the copy_expert method to load the data into the staging.raw_data table
with tempfile.TemporaryFile(mode = 'w+', encoding = 'utf-8', newline = "") as csv_file:
    # Write the DataFrame to the temp file in CSV format
    df[source_columns].to_csv(csv_file, index=False, header=False, na_rep='\\N')
    # Move the file pointer to the beginning of the file
    csv_file.seek(0)
    # Use copy_expert to load the data from the temp file into the staging.raw_data table
    curr.copy_expert(copy_sql, csv_file)

conn.commit()
curr.close()
conn.close()

print("Data loaded into the staging.raw_data table successfully.")

# Check the database if it loaded the data successfully