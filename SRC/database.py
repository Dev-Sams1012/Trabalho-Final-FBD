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

def listar_albuns():
    return faz_consulta("SELECT cod_album, descricao, meio_fisico, data_grav, g.nome as gravadora FROM Album a JOIN Gravadora g ON a.gravadora = g.cod_grav")

def listar_faixas_do_album(cod_album):
    return faz_consulta("SELECT num_faixa, f.descricao as descricao, num_disco FROM Faixa f WHERE f.album = %s ORDER BY num_disco, num_faixa",[cod_album])
    
def listar_playlists():
    return faz_consulta("SELECT cod_play, nome, data_criacao FROM Playlist")

def listar_faixas_da_playlist(cod_play):
    return faz_consulta("SELECT f.num_faixa as num_faixa, f.descricao as descricao, f.num_disco as num_disco FROM Faixa f JOIN Faixa_Playlist fp ON f.num_faixa = fp.num_faixa AND f.album = fp.album AND f.num_disco = fp.num_disco JOIN Playlist p ON fp.cod_play = p.cod_play ORDER BY num_disco, num_faixa",[cod_play])

def listar_compositores():
    return faz_consulta("SELECT cod_comp, nome, local_nasc, p.descricao as periodo_musical FROM Compositor c JOIN Periodo_Musical p ON c.periodo_musc = p.cod_per_musc")

def listar_interpretes():
    return faz_consulta("SELECT cod_inter, nome, tipo FROM Interprete")