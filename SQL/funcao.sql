CREATE FUNCTION FN_Albuns_Por_Compositor
(
    @nome_compositor VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT
        a.cod_album,
        a.descricao,
        a.data_compra,
        a.data_grav,
        a.meio_fisico,
        a.preco_compra
    FROM Compositor c
    JOIN Compositor_Faixa cf
        ON cf.cod_comp = c.cod_comp
    JOIN Faixa f
        ON f.num_faixa = cf.num_faixa
       AND f.album     = cf.album
       AND f.num_disco = cf.num_disco
    JOIN Album a
        ON a.cod_album = f.album
    WHERE c.nome LIKE '%' + @nome_compositor + '%'
);
