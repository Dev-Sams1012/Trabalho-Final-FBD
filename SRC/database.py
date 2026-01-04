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
def faz_consulta(consulta, parametros = None):
    try:
        with obter_conexao() as conn:
            with conn.cursor(as_dict=True) as cursor:
                if parametros:
                    cursor.execute(consulta, parametros)
                else:
                    cursor.execute(consulta)
                return cursor.fetchall()
    except Exception as e:
        print(f"Erro ao listar: {e}")
        return []
    
def exec_comando(comando, parametros = None):
    try:
        with obter_conexao() as conn:
            with conn.cursor() as cursor:
                if parametros:
                    cursor.execute(comando, parametros)
                else:
                    cursor.execute(comando)
                return True
    except Exception as e:
        print(f"Erro ao executar: {e}")
        return False

def listar_albuns():
    return faz_consulta(
        """SELECT cod_album, descricao, meio_fisico, data_grav, g.nome as gravadora 
        FROM Album a JOIN Gravadora g ON a.gravadora = g.cod_grav""")
    
def listar_faixas_do_album(cod_album):
    return faz_consulta(
        """SELECT num_faixa, f.descricao as descricao, num_disco 
        FROM Faixa f 
        WHERE f.album = %s 
        ORDER BY num_disco, num_faixa""", [cod_album])
    
def obter_album_id(descricao):
    sql = faz_consulta("SELECT cod_album FROM Album WHERE descricao = %s",[descricao])
    return sql[0]["cod_album"] if sql else None
    
def listar_playlists():
    return faz_consulta("SELECT cod_play, nome, data_criacao FROM Playlist")

def listar_faixas_da_playlist(cod_play):
    return faz_consulta(
        """SELECT f.num_faixa as num_faixa, f.descricao as descricao, f.num_disco as num_disco, f.album as album
        FROM Faixa f JOIN Faixa_Playlist fp ON f.num_faixa = fp.num_faixa AND f.album = fp.album AND f.num_disco = fp.num_disco AND fp.cod_play = %s 
        ORDER BY num_disco, num_faixa""", [cod_play])

def cria_playlist(nome, data, tempo):
    return exec_comando("INSERT INTO Playlist (nome, data_criacao, tempo_exec) VALUES (%s, %s, %s)", [nome, data, tempo])

def deleta_playlist(id_play):
    return exec_comando("DELETE FROM Playlist WHERE cod_play = %s", [id_play])

def obter_playlist_id(nome):
    sql = faz_consulta("SELECT cod_play FROM Playlist WHERE nome = %s",[nome])
    return sql[0]["cod_play"] if sql else None

def insere_faixa_playlist(num_faixa, album, num_disco, id_play):
    return exec_comando("INSERT INTO Faixa_Playlist (num_faixa, album, num_disco, cod_play, vezes_tocada, ultima_vez_tocada) VALUES (%s,%s,%s,%s, 0, CONVERT(date, GETDATE()))", [num_faixa, album, num_disco, id_play])

def deleta_faixa_playlist(num_faixa, album, num_disco, id_play):
    return exec_comando("DELETE FROM Faixa_Playlist WHERE num_faixa = %s AND album = %s AND num_disco = %s AND cod_play = %s", [num_faixa, album, num_disco, id_play])

def listar_compositores():
    return faz_consulta("SELECT cod_comp, nome, local_nasc, p.descricao as periodo_musical FROM Compositor c JOIN Periodo_Musical p ON c.periodo_musc = p.cod_per_musc")

def listar_interpretes():
    return faz_consulta("SELECT cod_inter, nome, tipo FROM Interprete")