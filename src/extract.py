import os
import pyodbc
import pandas as pd
import logging
from prefect.blocks.system import Secret
from logging_config import setup_logging

def extract_data(connection_string: str, data_object: str, local_storage: str) -> str:
    """
    Extract data from a database using a SQL query.

    Args:
    connection_string (str): Name of the Prefect storage block containing the database connection string.
    log_file (str): Name of the log file to use for logging.
    data_object (str): Name of the data object being extracted. This is used to construct the path of the sql, log, and csv files.
    """
    # Set up the paths for the SQL query, log file, and data file
    sql_file = f'queries/extract/{data_object}.sql'
    log_file = os.path.join(local_storage.basepath, 'logs', f'{data_object}.log')
    timestamp = pd.Timestamp.now().strftime('%Y%m%d%H%M%S')
    filename = os.path.join(local_storage.basepath, 'data', 'extracted_data', f'{data_object}_{timestamp}.csv.gz')

    # Set up logging
    setup_logging(log_file)
    
    # Fetch credentials from Prefect storage block
    credentials = Secret.load(connection_string).get()

    # Read the SQL query from the file
    with open(sql_file, 'r') as file:
        query = file.read()

    try:
        # Connect to the database
        connection = pyodbc.connect(credentials)

        # Create a cursor object using the connection
        cursor = connection.cursor()

        # Execute the SQL query
        cursor.execute(query)

        # Fetch all rows from the last executed statement
        rows = cursor.fetchall()

        # Get the column names from the cursor description
        columns = [column[0] for column in cursor.description]

        # Create a DataFrame from the rows and column names
        df = pd.DataFrame.from_records(rows, columns=columns)

        # Remove any `|` characters from the DataFrame as they will interfere with the CSV file
        df.replace(to_replace = '\\|', value = '', regex = True, inplace = True)

        # Close the cursor and connection
        cursor.close()
        connection.close()

        # Save the DataFrame to a CSV file
        df.to_csv(
            path_or_buf = filename
            , index = False
            , sep = '|'
            , encoding = 'UTF-8'
        )

        logging.info("Data extraction successful.")

        return filename, log_file
    
    except Exception as e:
        logging.error(f"Error extracting data: {e}")
        raise