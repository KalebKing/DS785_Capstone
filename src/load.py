import os
import pandas as pd
import logging
from prefect_snowflake import SnowflakeCredentials
from logging_config import setup_logging

def load_data(cursor, csv_file: str, stage_name: str, log_file: str):
    # Set up logging
    setup_logging(log_file)

    csv_file = csv_file.replace('\\', '/')

    try:
        # Execute the SQL query
        cursor.execute(f"""put 'file://{csv_file}' '@"{stage_name}"';""")

        # Get the file name without the path
        file_name = os.path.basename(csv_file)

        staged_file = f"""'@"{stage_name}"/{file_name}'"""

        logging.info("Data loaded to Snowflake successfully.")

        return staged_file

    except Exception as e:
        logging.error(f"Error loading data to Snowflake: {e}")
        raise