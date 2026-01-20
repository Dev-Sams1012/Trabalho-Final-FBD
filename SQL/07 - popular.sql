USE BDSpotPer;
GO

INSERT INTO Periodo_Musical (descricao, ano_inicio, ano_fim) VALUES 
('Barroco', 1600, 1750), ('Classico', 1750, 1820), ('Romantico', 1815, 1910), 
('Modernista', 1900, 1960), ('Contemporaneo', 1960, 2025);

INSERT INTO Tipo_Composicao (descricao) VALUES 
('Sinfonia'), ('Concerto'), ('Sonata'), ('Preludio'), ('Opera'), 
('Quarteto'), ('Bachiana'), ('Bale'), ('Noturno'), ('Suite');


INSERT INTO Gravadora (nome, numero_end, rua_end, bairro_end, cidade_end, estado_end, url_site) VALUES 
('Universal Music Group', 3500, 'Av. das Americas', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', 'https://www.universalmusic.com.br/'),
('Sony Music', 1063, 'Av. Paulista', 'Bela Vista', 'Sao Paulo', 'SP', 'https://www.sonymusic.com.br/'),
('Som Livre', 200, 'Av. Jose Silva', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', 'https://www.somlivre.com/');

INSERT INTO Telefone_Gravadora (gravadora, telefone) VALUES (1, '2130304042'), (2, '1123067092'), (3, '2111223344');


INSERT INTO Compositor (nome, local_nasc, data_nasc, data_mort, periodo_musc) VALUES 
('J.S. Bach', 'Alemanha', '1685-03-31', '1750-07-28', 1), 
('A. Vivaldi', 'Italia', '1678-03-04', '1741-07-28', 1),
('W.A. Mozart', 'Austria', '1756-01-27', '1791-12-05', 2), 
('L. Beethoven', 'Alemanha', '1770-12-17', '1827-03-26', 3),
('F. Chopin', 'Polonia', '1810-03-01', '1849-10-17', 3), 
('A. Dvorak', 'Republica Checa', '1841-09-08', '1904-05-01', 3),
('P. I. Tchaikovsky', 'Russia', '1840-05-07', '1893-11-06', 3),
('H. Villa-Lobos', 'Brasil', '1887-03-05', '1959-11-17', 4),
('J. Williams', 'Estados Unidos', '1932-02-08', NULL, 4),
('L. Dalla', 'Italia', '1943-03-04', '2012-03-01', 4);

INSERT INTO Interprete (nome, tipo) VALUES 
('Glenn Gould', 'Pianista'), ('Yo-Yo Ma', 'Cello'), ('Maria Callas', 'Soprano'), ('Lang Lang', 'Pianista'), ('Luciano Pavarotti', 'Tenor'), ('Berlin Philharmonic', 'Orquestra'), ('Vienna Philharmonic', 'Orquestra'), ('London Symph Orch', 'Orquestra'), ('New York Philharmonic', 'Orquestra');


INSERT INTO Album (descricao, data_compra, data_grav, meio_fisico, preco_compra, gravadora) VALUES 
('Goldberg Variations', '2024-01-10', '2018-05-12', 'CD', 45.00, 1),
('The Four Seasons', '2024-01-15', '2019-06-20', 'CD', 40.00, 1),
('Requiem', '2024-02-05', '2020-03-18', 'DOWNLOAD', 35.00, 2),
('Symphony No. 9', '2024-02-20', '2021-01-10', 'VINIL', 160.00, 2),
('Nocturnes', '2024-03-01', '2022-02-14', 'DOWNLOAD', 30.00, 2),
('Symphony No. 9 "From the New World"', '2024-03-10', '2020-09-25', 'CD', 60.00, 1),
('Swan Lake', '2024-03-15', '2021-11-05', 'CD', 65.00, 1),
('Bachianas Brasileiras No. 5', '2024-04-01', '2019-08-30', 'CD', 70.00, 3),
('Star Wars: Original Motion Picture Soundtrack', '2024-04-10', '2023-06-01', 'DOWNLOAD', 80.00, 3),
('Caruso', '2024-05-01', '2016-01-14', 'CD', 55.00, 3);


INSERT INTO Faixa (num_faixa, album, num_disco, descricao, tipo_comp, tempo_exec, tipo_grav) VALUES 
--bach
(1, 1, 1, 'Prelude No.1', 4, 180, 'DDD'),
(2, 1, 1, 'Prelude No.2', 4, 175, 'DDD'),
(3, 1, 1, 'Suite No.1',   10, 220, 'DDD'),
(4, 1, 1, 'Suite No.2',   10, 210, 'DDD'),
(5, 1, 1, 'Prelude No.3', 4, 190, 'DDD'),

--vivaldi
(1, 2, 1, 'Spring', 2, 600, 'DDD'),
(2, 2, 1, 'Summer', 2, 620, 'DDD'),
(3, 2, 1, 'Autumn', 2, 580, 'DDD'),
(4, 2, 1, 'Winter', 2, 610, 'DDD'),

--mozart
(1, 3, 1, 'Introitus: Requiem aeternam', 5, 600, NULL),
(2, 3, 1, 'Kyrie eleison', 5, 550, NULL),
(3, 3, 1, 'Dies irae', 5, 700, NULL),
(4, 3, 1, 'Lacrimosa', 5, 650, NULL),

--bethooven
(1, 4, 1, 'Allegro ma non troppo, un poco maestoso', 1, 900, NULL),
(2, 4, 1, 'Molto vivace', 1, 850, NULL),
(3, 4, 1, 'Adagio molto e cantabile', 1, 950, NULL),
(4, 4, 1, 'Presto - Allegro assai', 1, 920, NULL),

--chopin
(1, 5, 1, 'Noturno Op.9 No.1', 9, 300, NULL),
(2, 5, 1, 'Noturno Op.9 No.2', 9, 310, NULL),
(3, 5, 1, 'Noturno Op.15', 9, 320, NULL),
(4, 5, 1, 'Noturno Op.27', 9, 330, NULL),
(5, 5, 1, 'Noturno Op.48', 9, 340, NULL),

--dvorak
(1, 6, 1, 'Allegro con fuoco', 1, 800, 'ADD'),
(2, 6, 1, 'Largo', 1, 750, 'ADD'),
(3, 6, 1, 'Scherzo: Molto vivace', 1, 780, 'ADD'),
(4, 6, 1, 'Allegro giocoso', 1, 820, 'ADD'),

--tchaikovsky
(1, 7, 1, 'Scene 1: Introduction', 8, 400, 'ADD'),
(2, 7, 1, 'Scene 2: Dance of the Swans', 8, 450, 'ADD'),
(3, 7, 1, 'Scene 3: Pas de Deux', 8, 500, 'ADD'),
(4, 7, 1, 'Scene 4: Finale', 8, 550, 'ADD'),

--villa lobos
(1, 8, 1, 'Bachiana No.1', 7, 360, 'ADD'),
(2, 8, 1, 'Bachiana No.2', 7, 370, 'ADD'),
(3, 8, 1, 'Bachiana No.3', 7, 380, 'ADD'),
(4, 8, 1, 'Bachiana No.4', 7, 390, 'ADD'),
(5, 8, 1, 'Bachiana No.5', 7, 400, 'ADD'),

--j williams
(1, 9, 1, 'Main Title', 8, 300, NULL),
(2, 9, 1, 'The Imperial March', 8, 320, NULL),
(3, 9, 1, 'Yoda Theme', 8, 280, NULL),
(4, 9, 1, 'Duel of the Fates', 8, 350, NULL),

--l dalla
(1, 10, 1, 'Caruso', 10, 330, 'DDD');

--bach
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 1
FROM Faixa WHERE album = 1;

--vivaldi
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 2
FROM Faixa WHERE album = 2;

--mozart
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 3
FROM Faixa WHERE album = 3;

--beethoven
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 4
FROM Faixa WHERE album = 4;

--chopin
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 5
FROM Faixa WHERE album = 5;

--dvorak
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 6
FROM Faixa WHERE album = 6;

--tchaikovsky
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 7
FROM Faixa WHERE album = 7;

--villa lobos
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 8
FROM Faixa WHERE album = 8;

--j williams
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 9
FROM Faixa WHERE album = 9;

--l dalla
INSERT INTO Compositor_Faixa (num_faixa, album, num_disco, cod_comp)
SELECT num_faixa, album, num_disco, 10
FROM Faixa WHERE album = 10;

--bach
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 1
FROM Faixa WHERE album = 1;

--vivaldi
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 7
FROM Faixa WHERE album = 2;

--mozart
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 3
FROM Faixa WHERE album = 3;

--beethoven
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 6
FROM Faixa WHERE album = 4;

--chopin
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 4
FROM Faixa WHERE album = 5;

--dvorak
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 9
FROM Faixa WHERE album = 6;

--tchaikovsky
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 8
FROM Faixa WHERE album = 7;

--villa lobos
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 2
FROM Faixa WHERE album = 8;

--j williams
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 8
FROM Faixa WHERE album = 9;

--pavarotti
INSERT INTO Interprete_Faixa (num_faixa, album, num_disco, cod_inter)
SELECT num_faixa, album, num_disco, 5
FROM Faixa WHERE album = 10;


INSERT INTO Playlist (nome, data_criacao) VALUES 
('Favoritos', '2026-01-01'),
('Classicos Eternos', '2026-01-01'),
('Recomendacoes', '2026-01-01'),
('Concertos Barrocos', '2026-01-01');

INSERT INTO Faixa_Playlist (num_faixa, album, num_disco, cod_play, vezes_tocada, ultima_vez_tocada)
SELECT num_faixa, album, num_disco, 1, 6, '2026-01-01'
FROM Faixa
WHERE album IN (2, 5, 8);

INSERT INTO Faixa_Playlist (num_faixa, album, num_disco, cod_play, vezes_tocada, ultima_vez_tocada)
SELECT num_faixa, album, num_disco, 2, 7, '2026-01-01'
FROM Faixa
WHERE album IN (1, 3, 4);

INSERT INTO Faixa_Playlist (num_faixa, album, num_disco, cod_play, vezes_tocada, ultima_vez_tocada)
SELECT num_faixa, album, num_disco, 3, 8, '2026-01-01'
FROM Faixa
WHERE album IN (6, 7, 9, 10);

INSERT INTO Faixa_Playlist (num_faixa, album, num_disco, cod_play, vezes_tocada, ultima_vez_tocada)
SELECT num_faixa, album, num_disco, 4, 10, '2026-01-01'
FROM Faixa
WHERE album IN (2);


GO