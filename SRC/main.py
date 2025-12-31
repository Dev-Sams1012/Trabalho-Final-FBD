import os
import pymssql
from dotenv import load_dotenv

load_dotenv()

def obter_conexao():
    return pymssql.connect(
        server=os.getenv('DB_SERVER'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        database=os.getenv('DB_NAME')
    )
    
try:
    conn = obter_conexao()
    
    cursor = conn.cursor()
    cursor.execute('SELECT @@VERSION')
    row = cursor.fetchone()
    
    print("Conexão funcionou.")
    print(f"Versão do SQL Server: {row[0]}")
    
    conn.close()

except Exception as e:
    print(f"Erro: {e}")