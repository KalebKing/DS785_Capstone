import os
import pandas as pd
import logging
from prefect_snowflake import SnowflakeCredentials
from logging_config import setup_logging

def record_history(cursor, data_object: str, local_storage: str):

    # Set up logging
    log_file = os.path.join(local_storage.basepath, 'logs', f'{data_object}.log')
    setup_logging(log_file)

    try:
        # Create the history table if it doesn't exist
        if data_object not in ['sa_wert', 'sa_wertkopf', 'currency_exchange_rates', 'customer_invoice']:
            with open(f'queries/create/table/{data_object}_history.sql', 'r') as file:
                table_history_query = file.read()
            cursor.execute(table_history_query)

        # Insert records from the stream into the history table
        if data_object not in ['sa_wert', 'sa_wertkopf', 'currency_exchange_rates', 'customer_invoice']:
            with open(f'queries/transform/{data_object}/history.sql', 'r') as file:
                history_query = file.read()
            cursor.execute(history_query)

        logging.info("Data recorded to history table successfully.")

    except Exception as e:
        logging.error(f"Error loading data to Snowflake: {e}")
        raise