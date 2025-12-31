USE BDSpotPer;
GO

-- 1. LIMPEZA TOTAL

DELETE FROM Faixa_Playlist;
DELETE FROM Interprete_Faixa;
DELETE FROM Compositor_Faixa;
DELETE FROM Faixa;
DELETE FROM Playlist;
DELETE FROM Album;
DELETE FROM Telefone_Gravadora;
DELETE FROM Gravadora;
DELETE FROM Compositor;
DELETE FROM Tipo_Composicao;
DELETE FROM Periodo_Musical;
DELETE FROM Interprete;
GO

-- 2. INFRAESTRUTURA (Períodos, Tipos e Gravadoras)
INSERT INTO Periodo_Musical VALUES (1, 'Barroco', 1600, 1750), (2, 'Clássico', 1750, 1820), (3, 'Romântico', 1815, 1910), (4, 'Modernista', 1900, 1960), (5, 'Contemporâneo', 1960, 2025);

INSERT INTO Tipo_Composicao VALUES (1, 'Sinfonia'), (2, 'Concerto'), (3, 'Sonata'), (4, 'Prelúdio'), (5, 'Ópera'), (6, 'Quarteto'), (7, 'Bachiana'), (8, 'Balé'), (9, 'Noturno'), (10, 'Suíte');

INSERT INTO Gravadora VALUES 
(1, 'Deutsche Grammophon', 123, 'Allee 1', 'Mitte', 'Berlim', 'DE', 'http://dg.com'),
(2, 'Sony Classical', 456, 'Madison Ave', 'NY', 'New York', 'NY', 'http://sony.com'),
(3, 'Som Livre', 10, 'Rua Globo', 'Jardins', 'Rio', 'RJ', 'http://somlivre.com');

INSERT INTO Telefone_Gravadora VALUES (1, '4930111'), (1, '4930222'), (2, '1212555'), (3, '2122334');

-- 3. COMPOSITORES E INTÉRPRETES
INSERT INTO Compositor VALUES 
(1, 'J.S. Bach', 'Alemanha', '1685-03-31', '1750-07-28', 1), (2, 'A. Vivaldi', 'Itália', '1678-03-04', '1741-07-28', 1),
(3, 'W.A. Mozart', 'Áustria', '1756-01-27', '1791-12-05', 2), (4, 'L. Beethoven', 'Alemanha', '1770-12-17', '1827-03-26', 3),
(5, 'F. Chopin', 'Polônia', '1810-03-01', '1849-10-17', 3), (6, 'H. Villa-Lobos', 'Brasil', '1887-03-05', '1959-11-17', 4);

INSERT INTO Interprete VALUES 
(1, 'Glenn Gould', 'Pianista'), (2, 'Berlin Phil', 'Orquestra'), (3, 'Yo-Yo Ma', 'Cello'), 
(4, 'Maria Callas', 'Soprano'), (5, 'Lang Lang', 'Pianista'), (6, 'London Sym', 'Orquestra');

-- 4. ÁLBUNS
INSERT INTO Album VALUES 
(1, 'The Bach Experience', '2024-01-10', '2020-05-10', 'CD', 40.00, 1),
(2, 'Vivaldi Complete', '2024-02-15', '2021-06-15', 'CD', 35.00, 1),
(3, 'Beethoven Cycle', '2024-03-20', '2020-01-10', 'VINIL', 150.00, 2),
(4, 'Chopin Nocturnes', '2024-04-12', '2022-02-01', 'DOWNLOAD', 20.00, 2),
(5, 'Villa-Lobos Antologia', '2024-05-20', '2019-01-05', 'CD', 55.00, 3);

-- 5. FAIXAS (LOOP PARA VOLUME MASSIVO - 125 FAIXAS TOTAL)
DECLARE @f INT = 1;
-- Album 1 e 2 (CD/Barroco)
WHILE @f <= 30
BEGIN
    INSERT INTO Faixa VALUES (@f, 1, 1, CONCAT('Bach ', @f), 4, 180, 'DDD');
    INSERT INTO Faixa VALUES (@f, 2, 1, CONCAT('Vivaldi ', @f), 2, 200, 'DDD');
    SET @f = @f + 1;
END;

-- Album 3 e 4 (VINIL/DOWNLOAD)
SET @f = 1;
WHILE @f <= 25
BEGIN
    INSERT INTO Faixa VALUES (@f, 3, 1, CONCAT('Beeth ', @f), 1, 400, NULL);
    INSERT INTO Faixa VALUES (@f, 4, 1, CONCAT('Chopin ', @f), 9, 300, NULL);
    SET @f = @f + 1;
END;

-- Album 5 (CD/Moderno)
SET @f = 1;
WHILE @f <= 15
BEGIN
    INSERT INTO Faixa VALUES (@f, 5, 1, CONCAT('Villa ', @f), 7, 320, 'DDD');
    SET @f = @f + 1;
END;

-- 6. RELACIONAMENTOS

-- Compositores (Bach=1, Vivaldi=2, Beethoven=4, Chopin=5, Villa-Lobos=7)
INSERT INTO Compositor_Faixa SELECT num_faixa, album, num_disco, 1 FROM Faixa WHERE album = 1;
INSERT INTO Compositor_Faixa SELECT num_faixa, album, num_disco, 2 FROM Faixa WHERE album = 2;
INSERT INTO Compositor_Faixa SELECT num_faixa, album, num_disco, 4 FROM Faixa WHERE album = 3;
INSERT INTO Compositor_Faixa SELECT num_faixa, album, num_disco, 5 FROM Faixa WHERE album = 4;
INSERT INTO Compositor_Faixa SELECT num_faixa, album, num_disco, 6 FROM Faixa WHERE album = 5;

-- Intérpretes
INSERT INTO Interprete_Faixa SELECT num_faixa, album, num_disco, 1 FROM Faixa WHERE album IN (1, 4);
INSERT INTO Interprete_Faixa SELECT num_faixa, album, num_disco, 2 FROM Faixa WHERE album IN (2, 3);

-- Playlists e Faixas da Playlist
INSERT INTO Playlist VALUES (1, 'Foco Total', '2024-12-01', 9999), (2, 'Favoritos', '2025-01-01', 9999);
INSERT INTO Faixa_Playlist SELECT num_faixa, album, num_disco, 1, 10, '2024-12-31' FROM Faixa WHERE album <= 2;
INSERT INTO Faixa_Playlist SELECT num_faixa, album, num_disco, 2, 5, '2025-01-01' FROM Faixa WHERE album >= 3;

GO