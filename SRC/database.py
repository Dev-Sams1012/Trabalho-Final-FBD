import os
import pymssql
from dotenv import load_dotenv

load_dotenv()

def obter_conexao():
    return pymssql.connect(
        server=os.getenv('DB_SERVER'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        database=os.getenv('DB_NAME'),
        autocommit=True
    )

def listar_albuns():
    try:
        with obter_conexao() as conn:
            with conn.cursor(as_dict=True) as cursor:
                cursor.execute("SELECT cod_album, descricao, meio_fisico, data_grav, g.nome as gravadora FROM Album a JOIN Gravadora g ON a.gravadora = g.cod_grav")
                return cursor.fetchall()
    except Exception as e:
        print(f"Erro ao listar álbuns: {e}")
        return []
    
def listar_playlists():
    try:
        with obter_conexao() as conn:
            with conn.cursor(as_dict=True) as cursor:
                cursor.execute("SELECT cod_play, nome, data_criacao FROM Playlist")
                return cursor.fetchall()
    except Exception as e:
        print(f"Erro ao listar playlists: {e}")
        return []