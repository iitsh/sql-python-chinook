import sqlite3
import sys
from pathlib import Path

import pandas as pd

DB = Path("data/Chinook_Sqlite.sqlite")

def main():
    if len(sys.argv) < 2:
        raise SystemExit("Usage : python run_sql.py sql/01_ca_par_annee.sql")
    sql_file = Path(sys.argv[1])
    if not sql_file.exists():
        raise SystemExit(f"Requête introuvable : {sql_file}")
    if not DB.exists():
        raise SystemExit(f"Base introuvable : {DB.resolve()}")

    con = sqlite3.connect(DB)
    df = pd.read_sql_query(sql_file.read_text(encoding="utf-8"), con)
    con.close()

    if df.empty:
        print("Aucun résultat.")
    else:
        print(df.to_string(index=False))

if __name__ == "__main__":
    main()