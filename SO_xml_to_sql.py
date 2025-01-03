# imports xml from https://archive.org/details/stackexchange
# into sql tables via pandas

from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from lxml.etree import XMLParser, parse


# create database SO on (name='SO', filename='<custom_path>\test.db')
DRIVER = "ODBC Driver 17 for SQL Server"
USERNAME = ""
PSSWD = ""
SERVERNAME = "(localdb)\MSSQLLocalDB"
INSTANCENAME = "\SQLEXPRESS"
DB = "SO"
TABLE = ""


# connection_string = "DRIVER={ODBC Driver 17 for SQL Server};Server=(localdb)\MSSQLLocalDB;Integrated Security=true'"
# connection_url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})

connection_string = f"DRIVER={DRIVER};SERVER={SERVERNAME};DATABASE={DB};UID={USERNAME};PWD={PSSWD}"
connection_url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})
engine = create_engine(connection_url, fast_executemany=True, pool_pre_ping=True)


def import_xml(xml_file):
    # parser = XMLParser(huge_tree=True)
    # tree = parse(xml_file, parser=parser)
    # root = tree.getroot()
    #
    # data = [
    #     {elem.tag: elem.text for elem in row}
    #     for row in root.findall('.//row')
    # ]
    #
    # df = pd.DataFrame(data)

    df = pd.read_xml(xml_file, parser='etree')

    table_name = Path(xml_file).stem
    df.to_sql(table_name, engine, if_exists="replace", index=False, chunksize=500000)

    print(f"Data loaded into table '{table_name}'")


with engine.connect() as connection:
    import_xml("meta.stackexchange.com/Votes.xml")
    import_xml("meta.stackexchange.com/Tags.xml")
    import_xml("meta.stackexchange.com/Badges.xml")
    import_xml("meta.stackexchange.com/Comments.xml")
    import_xml("meta.stackexchange.com/PostHistory.xml")
    import_xml("meta.stackexchange.com/PostLinks.xml")
    import_xml("meta.stackexchange.com/Posts.xml")
    import_xml("meta.stackexchange.com/Tags.xml")
    import_xml("meta.stackexchange.com/Users.xml")