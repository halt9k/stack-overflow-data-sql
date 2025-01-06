# imports xml from https://archive.org/details/stackexchange
# into sql tables via pandas

from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL, Connection
from sqlalchemy.engine.mock import MockConnection

# create database SO on (name='SO', filename='<custom_path>\test.db')
DRIVER = "ODBC Driver 17 for SQL Server"
USERNAME = ""
PSSWD = ""
SERVERNAME = r"(localdb)\MSSQLLocalDB"
INSTANCENAME = r"\SQLEXPRESS"
DB = "SO"
TABLE = ""


def import_xml(engine: MockConnection, connection: Connection, xml_file):
    table_name = Path(xml_file).stem

    print(f"Starting '{table_name}'")
    df = pd.read_xml(xml_file, parser='etree')
    print(f"Pandas parsed '{table_name}'")

    if len(df) > 10:
        df = df[1:10]

    # existing_columns = pd.read_sql(f"SELECT * FROM {table_name} LIMIT 0", engine).columns
    existing_columns = pd.read_sql(f"SELECT TOP 0 * FROM {table_name}", engine).columns
    missing_columns = [col for col in df.columns if col not in existing_columns]
    if missing_columns:
        print(f"Columns {missing_columns} are missing in schema, skiping")
        df.drop(columns=missing_columns, inplace=True)

    # to_sql fails with bool to bit conversion
    df.loc[:, df.select_dtypes(bool).columns] = df.select_dtypes(bool).astype(int)

    df.to_sql(table_name, engine, if_exists="append", index=False, chunksize=500000, )
    # df.to_sql(table_name, engine, if_exists="replace", index=False, chunksize=500000)

    print(f"Data loaded into sql table '{table_name}'")


def import_so_xmls(engine: MockConnection, connection: Connection):
    import_xml(engine, connection, "meta.stackexchange.com/Tags.xml")
    import_xml(engine, connection, "meta.stackexchange.com/Badges.xml")
    import_xml(engine, connection, "meta.stackexchange.com/Comments.xml")
    import_xml(engine, connection, "meta.stackexchange.com/PostHistory.xml")
    import_xml(engine, connection, "meta.stackexchange.com/PostLinks.xml")
    import_xml(engine, connection, "meta.stackexchange.com/Posts.xml")
    import_xml(engine, connection, "meta.stackexchange.com/Tags.xml")
    import_xml(engine, connection, "meta.stackexchange.com/Users.xml")
    import_xml(engine, connection, "meta.stackexchange.com/Votes.xml")


def create_index(engine):

    pass


if __name__ == "__main__":
    connection_string = f"DRIVER={DRIVER};SERVER={SERVERNAME};DATABASE={DB};UID={USERNAME};PWD={PSSWD}"
    connection_url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})
    engine = create_engine(connection_url, fast_executemany=True, pool_pre_ping=True)

    with engine.connect() as connection:
        import_so_xmls(engine, connection)
        # create_index(engine)