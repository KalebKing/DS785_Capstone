import os
import pandas as pd
import logging
from prefect_snowflake import SnowflakeCredentials
from logging_config import setup_logging

def transform_data(cursor, staged_file: str, log_file: str, data_object: str):

    # Set up logging
    setup_logging(log_file)

    try:
        # Create a sequence if it doesn't exist
        if data_object not in ['sa_wert', 'sa_wertkopf', 'currency_exchange_rates']:
            with open(f'queries/create/sequence/{data_object}_key.sql', 'r') as file:
                sequence_query = file.read()
            cursor.execute(sequence_query)

        # Create the current table if it doesn't exist
        with open(f'queries/create/table/{data_object}.sql', 'r') as file:
            table_query = file.read()
        cursor.execute(table_query)

        # Create a stream if it doesn't exist
        if data_object not in ['sa_wert', 'sa_wertkopf', 'currency_exchange_rates', 'customer_invoice']:
            with open(f'queries/create/stream/{data_object}_cdc.sql', 'r') as file:
                stream_query = file.read()
            cursor.execute(stream_query)

        # Delete records from the current table that no longer exist in the source system
        with open(f'queries/transform/{data_object}/delete.sql', 'r') as file:
            delete_query = file.read()
            delete_query = delete_query.replace('<<FILENAME>>', staged_file)
        cursor.execute(delete_query)

        # Upsert records from the source system into the current table
        with open(f'queries/transform/{data_object}/upsert.sql', 'r') as file:
            upsert_query = file.read()
            upsert_query = upsert_query.replace('<<FILENAME>>', staged_file)
        cursor.execute(upsert_query)

        logging.info("Data loaded to Snowflake successfully.")

    except Exception as e:
        logging.error(f"Error loading data to Snowflake: {e}")
        raise