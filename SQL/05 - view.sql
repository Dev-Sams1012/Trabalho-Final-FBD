USE BDSpotPer;
GO

CREATE VIEW dbo.VW_Playlist_Album
WITH SCHEMABINDING
AS
SELECT
    p.cod_play,
    p.nome AS nome_playlist,
    f.album,
    COUNT_BIG(*) as count
FROM dbo.Playlist p
JOIN dbo.Faixa_Playlist fp
    ON fp.cod_play = p.cod_play
JOIN dbo.Faixa f
    ON f.num_faixa = fp.num_faixa
   AND f.album     = fp.album
   AND f.num_disco = fp.num_disco
GROUP BY
    p.cod_play,
    p.nome,
    f.album;
GO

CREATE UNIQUE CLUSTERED INDEX IX_VW_Playlist_Album
ON dbo.VW_Playlist_Album (cod_play, album);
GO

---

CREATE VIEW dbo.VW_Playlist_Qtd_Albuns
AS
SELECT
    cod_play,
    nome_playlist,
    COUNT(*) AS qtd_albuns
FROM dbo.VW_Playlist_Album
GROUP BY cod_play, nome_playlist;
GO

-- queria deixar ordenado, mas view n aceita order by