import sqlite3
from pathlib import Path

DB = Path("data/Chinook_Sqlite.sqlite")

if not DB.exists():
    raise SystemExit(f"Fichier introuvable : {DB.resolve()}")

con = sqlite3.connect(DB)
cur = con.cursor()

tables = [r[0] for r in cur.execute(
    "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name"
)]

print("Table            Lignes")
for t in tables:
    n = cur.execute(f'SELECT COUNT(*) FROM "{t}"').fetchone()[0]
    print(f"{t:<15}{n:>8}")

print()
print("Chiffre d'affaires total :", cur.execute("SELECT ROUND(SUM(Total), 2) FROM Invoice").fetchone()[0])
print("Première / dernière facture :", cur.execute("SELECT MIN(InvoiceDate), MAX(InvoiceDate) FROM Invoice").fetchone())

con.close()