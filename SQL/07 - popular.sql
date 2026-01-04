USE BDSpotPer;
GO

-- 1. LIMPEZA TOTAL E RESET DE IDENTIDADES
DELETE FROM Interprete_Faixa;
DELETE FROM Compositor_Faixa;
DELETE FROM Faixa;
DELETE FROM Faixa_Playlist;
DELETE FROM Telefone_Gravadora;
DELETE FROM Playlist;
DBCC CHECKIDENT ('Playlist', RESEED, 0);
DELETE FROM Album;
DBCC CHECKIDENT ('Album', RESEED, 0);
DELETE FROM Compositor;
DBCC CHECKIDENT ('Compositor', RESEED, 0);
DELETE FROM Gravadora;
DBCC CHECKIDENT ('Gravadora', RESEED, 0);
DELETE FROM Tipo_Composicao;
DBCC CHECKIDENT ('Tipo_Composicao', RESEED, 0);
DELETE FROM Periodo_Musical;
DBCC CHECKIDENT ('Periodo_Musical', RESEED, 0);
DELETE FROM Interprete;
DBCC CHECKIDENT ('Interprete', RESEED, 0);
GO

-- 2. INFRAESTRUTURA
INSERT INTO Periodo_Musical (descricao, ano_inicio, ano_fim) VALUES 
('Barroco', 1600, 1750), ('Clássico', 1750, 1820), ('Romântico', 1815, 1910), 
('Modernista', 1900, 1960), ('Contemporâneo', 1960, 2025);

INSERT INTO Tipo_Composicao (descricao) VALUES 
('Sinfonia'), ('Concerto'), ('Sonata'), ('Prelúdio'), ('Ópera'), 
('Quarteto'), ('Bachiana'), ('Balé'), ('Noturno'), ('Suíte');

INSERT INTO Gravadora (nome, numero_end, rua_end, bairro_end, cidade_end, estado_end, url_site) VALUES 
('Deutsche Grammophon', 123, 'Allee 1', 'Mitte', 'Berlim', 'DE', 'http://dg.com'),
('Sony Classical', 456, 'Madison Ave', 'NY', 'New York', 'NY', 'http://sony.com'),
('Som Livre', 10, 'Rua Globo', 'Jardins', 'Rio', 'RJ', 'http://somlivre.com');

INSERT INTO Telefone_Gravadora (gravadora, telefone) VALUES (1, '4930111'), (2, '1212555'), (3, '2122334');

-- 3. COMPOSITORES E INTÉRPRETES
INSERT INTO Compositor (nome, local_nasc, data_nasc, data_mort, periodo_musc) VALUES 
('J.S. Bach', 'Alemanha', '1685-03-31', '1750-07-28', 1), 
('A. Vivaldi', 'Itália', '1678-03-04', '1741-07-28', 1),
('W.A. Mozart', 'Áustria', '1756-01-27', '1791-12-05', 2), 
('L. Beethoven', 'Alemanha', '1770-12-17', '1827-03-26', 3),
('F. Chopin', 'Polônia', '1810-03-01', '1849-10-17', 3), 
('H. Villa-Lobos', 'Brasil', '1887-03-05', '1959-11-17', 4);

INSERT INTO Interprete (nome, tipo) VALUES 
('Glenn Gould', 'Pianista'), ('Berlin Phil', 'Orquestra'), ('Yo-Yo Ma', 'Cello'), 
('Maria Callas', 'Soprano'), ('Lang Lang', 'Pianista'), ('London Sym', 'Orquestra');

-- 4. ÁLBUNS
INSERT INTO Album (descricao, data_compra, data_grav, meio_fisico, preco_compra, gravadora) VALUES 
('The Bach Experience', '2024-01-10', '2020-05-10', 'CD', 40.00, 1),
('Vivaldi Complete', '2024-02-15', '2021-06-15', 'CD', 35.00, 1),
('Beethoven Cycle', '2024-03-20', '2020-01-10', 'VINIL', 150.00, 2),
('Chopin Nocturnes', '2024-04-12', '2022-02-01', 'DOWNLOAD', 20.00, 2),
('Villa-Lobos Antologia', '2024-05-20', '2019-01-05', 'CD', 55.00, 3);

-- 5. FAIXAS
DECLARE @f INT = 1;
WHILE @f <= 30
BEGIN
    INSERT INTO Faixa (num_faixa, album, num_disco, descricao, tipo_comp, tempo_exec, tipo_grav) 
    VALUES (@f, 1, 1, CONCAT('Bach ', @f), 4, 180, 'DDD'),
           (@f, 2, 1, CONCAT('Vivaldi ', @f), 2, 200, 'DDD');
    SET @f = @f + 1;
END;

SET @f = 1;
WHILE @f <= 25
BEGIN
    INSERT INTO Faixa (num_faixa, album, num_disco, descricao, tipo_comp, tempo_exec, tipo_grav) 
    VALUES (@f, 3, 1, CONCAT('Beeth ', @f), 1, 400, NULL),
           (@f, 4, 1, CONCAT('Chopin ', @f), 9, 300, NULL);
    SET @f = @f + 1;
END;

SET @f = 1;
WHILE @f <= 15
BEGIN
    INSERT INTO Faixa (num_faixa, album, num_disco, descricao, tipo_comp, tempo_exec, tipo_grav) 
    VALUES (@f, 5, 1, CONCAT('Villa ', @f), 7, 320, 'ADD');
    SET @f = @f + 1;
END;

-- 6. RELACIONAMENTOS
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp) 
SELECT num_faixa, album, num_disco, 1 FROM Faixa WHERE album = 1;
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp) 
SELECT num_faixa, album, num_disco, 2 FROM Faixa WHERE album = 2;
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp) 
SELECT num_faixa, album, num_disco, 4 FROM Faixa WHERE album = 3;
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp) 
SELECT num_faixa, album, num_disco, 5 FROM Faixa WHERE album = 4;
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp) 
SELECT num_faixa, album, num_disco, 6 FROM Faixa WHERE album = 5;

INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 1 FROM Faixa WHERE album IN (1, 4);
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 2 FROM Faixa WHERE album IN (2, 3);

-- Playlists
INSERT INTO Playlist (nome, data_criacao, tempo_exec) VALUES 
('Foco Total', '2024-12-01', 9999), 
('Favoritos', '2025-01-01', 9999);

-- Faixas da Playlist
INSERT INTO Faixa_Playlist (num_faixa, album, num_disco, cod_play, vezes_tocada, ultima_vez_tocada)
SELECT num_faixa, album, num_disco, 1, 10, '2024-12-31' FROM Faixa WHERE album <= 2;

INSERT INTO Faixa_Playlist (num_faixa, album, num_disco, cod_play, vezes_tocada, ultima_vez_tocada)
SELECT num_faixa, album, num_disco, 2, 5, '2025-01-01' FROM Faixa WHERE album >= 3;
GO