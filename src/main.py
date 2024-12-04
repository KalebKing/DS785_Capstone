from prefect import task, flow, tags
from connect import connect_to_snowflake
from extract import extract_data
from load import load_data
from transform import transform_data
from history import record_history

@task(name = "connect")
def connect_task(target_credentials, local_filesystem):
    connection, cursor, local_storage = connect_to_snowflake(target_credentials, local_filesystem)
    return connection, cursor, local_storage

@task(name = "extract")
def extract_task(source_credentials, data_object, local_storage):
    csv_file, log_file = extract_data(source_credentials, data_object, local_storage)
    return csv_file, log_file

@task(name = "load")
def load_task(cursor, csv_file, stage_name, log_file):
    staged_file = load_data(cursor, csv_file, stage_name, log_file)
    return staged_file

@task(name = "transform")
def transform_task(cursor, staged_file, log_file, data_object):
    return transform_data(cursor, staged_file, log_file, data_object)

@task(name = "history")
def history_task(cursor, data_object, local_storage):
    return record_history(cursor, data_object, local_storage)

@flow(name="proALPHA to Snowflake Data Pipeline")
def elt_flow(source_credentials: str, target_credentials: str, stage_name: str, data_objects: list, local_filesystem: str):
    connection, cursor, local_storage = connect_task(target_credentials, local_filesystem)
    
    try:
        cursor.execute("begin transaction;")

        for data_object in data_objects:

            with tags(data_object):
                csv_file, log_file = extract_task(source_credentials, data_object, local_storage)
                staged_file = load_task(cursor, csv_file, stage_name, log_file)
                transform_task(cursor, staged_file, log_file, data_object)

        cursor.execute("commit;")

        cursor.execute("begin transaction;")

        for data_object in data_objects:
            
            with tags(data_object):
                history_task(cursor, data_object, local_storage)

        cursor.execute("commit;")

    except Exception as e:
        cursor.execute("rollback;")
        raise

    finally:
        cursor.close()
        connection.close()

if __name__ == "__main__":

    elt_flow(
        source_credentials = 'esser-openedge-production-connection-string'
        , target_credentials = 'esser-snowflake-prefect'
        , stage_name = 'proALPHA'
        , data_objects = [
            'customer'
            , 'product'
            , 'vendor'
            , 'ship_to'
            , 'gl_account'
            , 'customer_quote'
            # , 'purchase_order'
            # , 'customer_order'
            # , 'customer_invoice'
            # , 'gl_activity'
        ]
        , local_filesystem = 'esser-data-warehouse-local-files'
    )