# imports xml from https://archive.org/details/stackexchange
# into sql tables via pandas

from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# create database SO on (name='SO', filename='<custom_path>\test.db')
DRIVER = "ODBC Driver 17 for SQL Server"
USERNAME = ""
PSSWD = ""
SERVERNAME = r"(localdb)\MSSQLLocalDB"
INSTANCENAME = r"\SQLEXPRESS"
DB = "SO"
TABLE = ""


def import_xml(engine, xml_file):
    df = pd.read_xml(xml_file, parser='etree')
    table_name = Path(xml_file).stem
    df.to_sql(table_name, engine, if_exists="replace", index=False, chunksize=500000)

    print(f"Data loaded into table '{table_name}'")


def import_so_xmls(engine):
    import_xml(engine, "meta.stackexchange.com/Votes.xml")
    import_xml(engine, "meta.stackexchange.com/Tags.xml")
    import_xml(engine, "meta.stackexchange.com/Badges.xml")
    import_xml(engine, "meta.stackexchange.com/Comments.xml")
    import_xml(engine, "meta.stackexchange.com/PostHistory.xml")
    import_xml(engine, "meta.stackexchange.com/PostLinks.xml")
    import_xml(engine, "meta.stackexchange.com/Posts.xml")
    import_xml(engine, "meta.stackexchange.com/Tags.xml")
    import_xml(engine, "meta.stackexchange.com/Users.xml")


def create_index(engine):
    pass


if __name__ == "__main__":
    connection_string = f"DRIVER={DRIVER};SERVER={SERVERNAME};DATABASE={DB};UID={USERNAME};PWD={PSSWD}"
    connection_url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})
    engine = create_engine(connection_url, fast_executemany=True, pool_pre_ping=True)

    with engine.connect() as connection:
        # import_so_xmls(engine)
        create_index(engine)