USE BDSpotPer
GO

CREATE TRIGGER TR_limite_64_faixas 
on Faixa
AFTER INSERT, UPDATE
AS 
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM (
            SELECT album, count(*) as total_faixas
            FROM Faixa
            WHERE album IN (SELECT DISTINCT album FROM inserted)
            GROUP BY album
        ) t
        WHERE t.total_faixas > 64
    )
    BEGIN
        RAISERROR (
            'Um álbum não pode conter mais de 64 faixas', 
            16,
            1
        );
        ROLLBACK TRANSACTION
    END
END;
GO

CREATE TRIGGER TR_barroco_so_DDD
ON Faixa
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted WHERE tipo_grav <> 'DDD' OR tipo_grav IS NULL)
    BEGIN
        IF EXISTS (
            SELECT 1 
            FROM Compositor_Faixa cf
            JOIN Compositor c ON cf.cod_comp = c.cod_comp
            JOIN Periodo_Musical p ON c.periodo_musc = p.cod_per_musc
            WHERE p.descricao = 'Barroco'
              AND cf.album IN (SELECT album FROM inserted)
        )
        BEGIN
            RAISERROR (
                'Este álbum possui obras Barrocas, portanto todas as faixas devem ser gravadas em DDD.', 
                16, 
                1
            );
            ROLLBACK TRANSACTION;
        END
    END
END;
GO

CREATE TRIGGER TR_meio_fisico_tipo_grav
ON Faixa
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Album a
            ON a.cod_album = i.album
        WHERE
            (
                a.meio_fisico = 'CD'
                AND i.tipo_grav IS NULL
            )
            OR
            (
                a.meio_fisico IN ('VINIL', 'DOWNLOAD')
                AND i.tipo_grav IS NOT NULL
            )
    )
    BEGIN
        RAISERROR (
            'Regra violada: tipo de gravação inválido para o meio físico do álbum.',
            16,
            1
        );
        ROLLBACK TRANSACTION;
    END
END;
GO

CREATE TRIGGER TR_preco_compra_album
ON Album
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @media_ddd DECIMAL(10,2);
    
    SELECT @media_ddd = AVG(a.preco_compra)
    FROM Album a
    WHERE NOT EXISTS (
        SELECT 1
        FROM Faixa f
        WHERE f.album = a.cod_album
          AND (f.tipo_grav IS NULL OR f.tipo_grav <> 'DDD')
    );
    
    IF @media_ddd IS NULL
        RETURN;
    
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.preco_compra > 3 * @media_ddd
    )
    BEGIN
        RAISERROR (
            'O preço de compra de um álbum não pode ser superior a três vezes a média do preço de álbuns com todas as faixas DDD.',
            16,
            1
        );
        ROLLBACK TRANSACTION;
    END
END;
GO

CREATE TRIGGER TR_atualiza_tempo_playlist
ON Faixa_Playlist
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Playlist
    SET tempo_exec = (
        SELECT ISNULL(SUM(f.tempo_exec), 0)
        FROM Faixa f
        JOIN Faixa_Playlist fp 
            ON f.num_faixa = fp.num_faixa 
            AND f.album = fp.album 
            AND f.num_disco = fp.num_disco
        WHERE fp.cod_play = Playlist.cod_play
    )
    WHERE cod_play IN (SELECT cod_play FROM inserted)
       OR cod_play IN (SELECT cod_play FROM deleted);
END;