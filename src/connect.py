import logging
import os
from prefect.filesystems import LocalFileSystem
from prefect_snowflake import SnowflakeCredentials
from logging_config import setup_logging

def connect_to_snowflake(target_credentials: str, local_filesystem: str):
    # Set up the path for the log file
    local_storage = LocalFileSystem.load(local_filesystem)
    log_file = os.path.join(local_storage.basepath, 'logs', 'connect.log')
    
    # Set up logging
    setup_logging(log_file)

    try:
        # Fetch credentials from Prefect storage block
        credentials = SnowflakeCredentials.load(target_credentials)

        # Connect to Snowflake
        connection = credentials.get_client()

        # Create a cursor object using the connection
        cursor = connection.cursor()

        # Set the role, warehouse, database, schema, file format, and stage
        cursor.execute("use role sysadmin;")
        cursor.execute("use warehouse default_wh;")
        cursor.execute("use database production;")
        cursor.execute(
            """
            create schema if not exists production.star
                comment = 'Contains fact and dimension tables in the star schema for the production database.'
                ;
            """
        )
        cursor.execute("use schema star;")
        cursor.execute(
            """
            create file format if not exists production.star."Pipe Separated"
                type = csv
                field_delimiter = '|'
                skip_header = 1
                trim_space = true
                null_if = ''
                encoding = 'UTF8'
                comment = 'Used for reading data files in the proALPHA stage. It defines a CSV file format with pipe ''|'' separated fields, skips header in first row, trims leading and trailing spaces from fields, and uses ISO-8859-1 encoding to handle German characters.'
                ;
            """
        )
        cursor.execute(
            """
            create stage if not exists production.star."proALPHA"
                encryption = (type = 'snowflake_full')
                directory = (enable = true)
                file_format = '"Pipe Separated"'
                comment = 'Staging area for flat files coming from proALPHA database.'
                ;
            """
        )

        logging.info("Connected to Snowflake successfully.")

        return connection, cursor, local_storage

    except Exception as e:
        logging.error(f"Error connecting to Snowflake: {e}")
        raise