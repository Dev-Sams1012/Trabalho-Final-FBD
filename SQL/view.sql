CREATE VIEW VW_Playlist_Qtd_Albuns
WITH SCHEMABINDING
AS
SELECT 
    p.cod_play,
    p.nome AS nome_playlist,
    COUNT(DISTINCT f.album) AS qtd_albuns
FROM dbo.Playlist p
JOIN dbo.Faixa_Playlist fp
    ON fp.cod_play = p.cod_play
JOIN dbo.Faixa f
    ON f.num_faixa = fp.num_faixa
   AND f.album     = fp.album
   AND f.num_disco = fp.num_disco
GROUP BY p.cod_play, p.nome;