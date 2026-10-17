import os
import pandas as pd
from sqlalchemy import create_engine
from config.config import DB_HOST,DB_USER,DB_PASSWORD,DB_NAME
connection_string = f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}'
engine = create_engine(connection_string)
csv_file_path = 'data/cleaned_data/clean_stock_market.csv'
df_processed = pd.read_csv(csv_file_path)
table_name = 'stock_data'
df_processed.to_sql(name=table_name,con=engine,if_exists='replace',index=False)
print(f"success! Data successfully loaded into MySQL table:'{table_name}'")