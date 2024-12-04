import logging
from logging.handlers import RotatingFileHandler

def setup_logging(log_file_path:str)->None:
    """
    Set up logging configuration

    Parameters
    ----------
    log_file_path : str
        Path to the log file

    Returns
    -------
    None

    Example
    -------
    >>> setup_logging('logs/pipeline.log')

    """
    # Create a logger
    logger = logging.getLogger()
    
    # Clear any existing handlers
    if logger.hasHandlers():
        logger.handlers.clear()

    # Set the logging level
    logger.setLevel(logging.INFO)
    
    # Create a file handler
    file_handler = RotatingFileHandler(log_file_path, maxBytes=5*1024*1024, backupCount=2)
    
    # Create a formatter and add it to handler
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    file_handler.setFormatter(formatter)
    
    # Add the file handler to the logger
    logger.addHandler(file_handler)