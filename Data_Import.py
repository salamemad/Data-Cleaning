import pandas as pd;
import pyodbc;
server = 'server'
database = 'database name'
username = 'your usename'
password = 'password'
driver = '{SQL Server}'

# Create a connection string
conn_str = f'DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password}'

# Establish a connection
conn = pyodbc.connect(conn_str)

excel_file_path = r"C:\Users\157009\OneDrive - Arrow Electronics, Inc\Desktop\movies.xlsx"
df = pd.read_excel(excel_file_path, sheet_name='movies')

table_name = "top_1000_movie"
# Insert data into SQL Server
df.to_sql(name=full_table_name, con=conn, if_exists='replace', index=False)
conn.close()

#################################
# import pyodbc

# List all available ODBC drivers
#drivers = [driver for driver in pyodbc.drivers()]

# Print the list of drivers
#print(drivers)