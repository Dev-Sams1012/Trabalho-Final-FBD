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
        """SELECT cod_album, descricao, meio_fisico, data_grav, g.nome AS gravadora 
        FROM Album a JOIN Gravadora g ON a.gravadora = g.cod_grav""")
    
def listar_faixas_do_album(cod_album):
    return faz_consulta(
        """SELECT num_faixa, f.descricao AS descricao, num_disco 
        FROM Faixa f 
        WHERE f.album = %s 
        ORDER BY num_disco, num_faixa""", [cod_album])
    
def obter_album_id(descricao):
    sql = faz_consulta("SELECT cod_album FROM Album WHERE descricao = %s",[descricao])
    return sql[0]["cod_album"] if sql else None
    
def listar_playlists():
    return faz_consulta("SELECT cod_play, nome, data_criacao, tempo_exec FROM Playlist")

def listar_faixas_da_playlist(cod_play):
    return faz_consulta("""
        SELECT f.num_faixa AS num_faixa, f.descricao AS descricao, f.num_disco AS num_disco, f.album AS album
        FROM Faixa f JOIN Faixa_Playlist fp ON f.num_faixa = fp.num_faixa AND f.album = fp.album AND f.num_disco = fp.num_disco AND fp.cod_play = %s 
        ORDER BY num_disco, num_faixa""", [cod_play])

def cria_playlist(nome, data):
    return exec_comando("INSERT INTO Playlist (nome, data_criacao) VALUES (%s, %s)", [nome, data])

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
    return faz_consulta("SELECT cod_comp, nome, local_nasc, p.descricao AS periodo_musical FROM Compositor c JOIN Periodo_Musical p ON c.periodo_musc = p.cod_per_musc")

def listar_interpretes():
    return faz_consulta("SELECT cod_inter, nome, tipo FROM Interprete")

def listar_albuns_preco_acima_media():
    return faz_consulta("""SELECT descricao, preco_compra FROM Album WHERE preco_compra > (SELECT AVG(preco_compra) FROM Album)""")

def listar_gravadora_maior_qtd_Dvorack():
    return faz_consulta("""
        SELECT g.nome AS nome_gravadora, COUNT(DISTINCT fp.cod_play) AS total_playlists
        FROM Gravadora g
        JOIN Album a
            ON a.gravadora = g.cod_grav
        JOIN Faixa f
            ON f.album = a.cod_album
        JOIN Compositor_Faixa cf
            ON cf.num_faixa = f.num_faixa
           AND cf.album     = f.album
           AND cf.num_disco = f.num_disco
        JOIN Compositor c
            ON c.cod_comp = cf.cod_comp
        JOIN Faixa_Playlist fp
            ON fp.num_faixa = f.num_faixa
           AND fp.album     = f.album
           AND fp.num_disco = f.num_disco
        WHERE c.nome = 'Dvorack'
        GROUP BY g.cod_grav, g.nome
        HAVING COUNT(DISTINCT fp.cod_play) = (
            SELECT MAX(qtd)
            FROM (
                SELECT COUNT(DISTINCT fp2.cod_play) AS qtd
                FROM Gravadora g2
                JOIN Album a2 ON a2.gravadora = g2.cod_grav
                JOIN Faixa f2 ON f2.album = a2.cod_album
                JOIN Compositor_Faixa cf2
                    ON cf2.num_faixa = f2.num_faixa
                   AND cf2.album     = f2.album
                   AND cf2.num_disco = f2.num_disco
                JOIN Compositor c2 ON c2.cod_comp = cf2.cod_comp
                JOIN Faixa_Playlist fp2
                    ON fp2.num_faixa = f2.num_faixa
                   AND fp2.album     = f2.album
                   AND fp2.num_disco = f2.num_disco
                WHERE c2.nome = 'Dvorack'
                GROUP BY g2.cod_grav
            ) sub
        )
    """)


def compositor_mais_faixas():
    return faz_consulta("""
        SELECT 
            c.nome AS nome,
            COUNT(*) AS total_faixas
        FROM Compositor c
        JOIN Compositor_Faixa cf
            ON cf.cod_comp = c.cod_comp
        JOIN Faixa_Playlist fp
            ON fp.num_faixa = cf.num_faixa
           AND fp.album     = cf.album
           AND fp.num_disco = cf.num_disco
        GROUP BY c.cod_comp, c.nome
        HAVING COUNT(*) = (
            SELECT MAX(qtd_faixas)
            FROM (
                SELECT COUNT(*) AS qtd_faixas
                FROM Compositor_Faixa cf2
                JOIN Faixa_Playlist fp2
                    ON fp2.num_faixa = cf2.num_faixa
                   AND fp2.album     = cf2.album
                   AND fp2.num_disco = cf2.num_disco
                GROUP BY cf2.cod_comp
            ) t1
        )
    """)

def listar_playlists_concerto_barroco():
    return faz_consulta("""
        SELECT p.cod_play, p.nome
        FROM Playlist p
        WHERE NOT EXISTS (
            SELECT *
            FROM Faixa_Playlist fp
            JOIN Faixa f
                ON f.num_faixa = fp.num_faixa
                AND f.album    = fp.album
                AND f.num_disco = fp.num_disco
            JOIN Tipo_Composicao tc
                ON tc.cod_tipo_comp = f.tipo_comp
            WHERE fp.cod_play = p.cod_play
            AND tc.descricao <> 'Concerto'
        )
        AND NOT EXISTS (
            SELECT *
            FROM Faixa_Playlist fp
            JOIN Faixa f
                ON f.num_faixa = fp.num_faixa
                AND f.album    = fp.album
                AND f.num_disco = fp.num_disco
            WHERE fp.cod_play = p.cod_play
            AND NOT EXISTS (
                SELECT *
                FROM Compositor_Faixa cf
                JOIN Compositor c
                    ON c.cod_comp = cf.cod_comp
                JOIN Periodo_Musical pm
                    ON pm.cod_per_musc = c.periodo_musc
                WHERE cf.num_faixa = f.num_faixa
                    AND cf.album    = f.album
                    AND cf.num_disco = f.num_disco
                    AND pm.descricao = 'Barroco'
            )
        )
    """)