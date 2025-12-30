USE BDSpotPer

CREATE TABLE Periodo_Musical
(
    cod_per_musc SMALLINT NOT NULL,
    descricao VARCHAR(20) NOT NULL,
    ano_inicio SMALLINT NOT NULL,
    ano_fim SMALLINT NOT NULL,

    CONSTRAINT PK_cod_per_musc PRIMARY KEY (cod_per_musc),

    CONSTRAINT CK_periodo_anos CHECK (ano_inicio < ano_fim),

    CONSTRAINT UQ_descricao UNIQUE (descricao)

) on FG_DADOS_GERAIS;

CREATE TABLE Compositor
(
    cod_comp SMALLINT NOT NULL,
    nome VARCHAR(20) NOT NULL,
    local_nasc VARCHAR(20),
    data_nasc DATE NOT NULL,
    data_mort DATE,
    periodo_musc SMALLINT NOT NULL,

    CONSTRAINT PK_cod_comp PRIMARY KEY (cod_comp),

    CONSTRAINT FK_comp_periodo FOREIGN KEY (periodo_musc) REFERENCES Periodo_Musical(cod_per_musc),

    CONSTRAINT CK_data CHECK (data_mort IS NULL OR data_nasc < data_mort)

) on FG_DADOS_GERAIS;

CREATE TABLE Tipo_Composicao
(
    cod_tipo_comp SMALLINT NOT NULL,
    descricao VARCHAR(20) NOT NULL,

    CONSTRAINT PK_cod_tipo_comp PRIMARY KEY (cod_tipo_comp)

) on FG_DADOS_GERAIS;

CREATE TABLE Interprete
(
    cod_inter SMALLINT NOT NULL,
    nome VARCHAR(20) NOT NULL,
    tipo VARCHAR(20),

    CONSTRAINT PK_cod_inter PRIMARY KEY (cod_inter)

) on FG_DADOS_GERAIS;

CREATE TABLE Gravadora
(
    cod_grav SMALLINT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    numero_end SMALLINT NOT NULL,
    rua_end VARCHAR(20) NOT NULL,
    bairro_end VARCHAR(10) NOT NULL,
    cidade_end VARCHAR(20) NOT NULL,
    estado_end CHAR(2) NOT NULL,
    url_site VARCHAR(100),

    CONSTRAINT PK_cod_grav PRIMARY KEY (cod_grav),

    CONSTRAINT UQ_grav_nome UNIQUE (nome),

    CONSTRAINT UQ_url_site UNIQUE (url_site)

) on FG_DADOS_GERAIS;

CREATE TABLE Telefone_Gravadora
(
    gravadora SMALLINT NOT NULL,
    telefone VARCHAR(15) NOT NULL,

    CONSTRAINT PK_tel_gravadora PRIMARY KEY (gravadora, telefone),

    CONSTRAINT FK_tel_gravadora FOREIGN KEY (gravadora) REFERENCES Gravadora(cod_grav)

) on FG_DADOS_GERAIS;

CREATE TABLE Album
(
    cod_album SMALLINT NOT NULL,
    descricao varchar(30) NOT NULL,
    data_compra DATE NOT NULL,
    data_grav DATE NOT NULL,
    meio_fisico VARCHAR(10) NOT NULL,
    preco_compra DEC(6,2),
    gravadora SMALLINT NOT NULL,

    CONSTRAINT PK_album PRIMARY KEY (cod_album),
    CONSTRAINT FK_album_gravadora FOREIGN KEY (gravadora) REFERENCES Gravadora(cod_grav),
    CONSTRAINT CK_album_data_grav CHECK (data_grav >= '2000-01-01'),
    CONSTRAINT CK_meio_fisico CHECK (meio_fisico IN ('CD','VINIL','DOWNLOAD'))


) on FG_DADOS_GERAIS;

CREATE TABLE Faixa
(
    num_faixa TINYINT NOT NULL,
    album SMALLINT NOT NULL,
    num_disco TINYINT NOT NULL,
    descricao VARCHAR(10),
    tipo_comp SMALLINT NOT NULL,
    tempo_exec SMALLINT,
    tipo_grav VARCHAR(3),

    CONSTRAINT PK_faixa PRIMARY KEY (num_faixa, album, num_disco),

    CONSTRAINT FK_faixa_album FOREIGN KEY (album) REFERENCES Album(cod_album)
    ON DELETE CASCADE,

    CONSTRAINT FK_faixa_tipo_comp FOREIGN KEY (tipo_comp) REFERENCES Tipo_Composicao(cod_tipo_comp),

    CONSTRAINT CK_tempo_exec_faixa CHECK (tempo_exec > 0),

    CONSTRAINT CK_tipo_grav_faixa CHECK (tipo_grav IN ('ADD','DDD'))

) on FG_PLAYLISTS;

CREATE TABLE Playlist
(
    cod_play SMALLINT NOT NULL,
    nome VARCHAR(20) NOT NULL,
    data_criacao DATE NOT NULL,
    tempo_exec SMALLINT,

    CONSTRAINT PK_playlist PRIMARY KEY (cod_play),

    CONSTRAINT CK_tempo_exec_playlist CHECK (tempo_exec > 0)

) on FG_PLAYLISTS;

CREATE TABLE Faixa_Playlist
(
    num_faixa TINYINT NOT NULL,
    album SMALLINT NOT NULL,
    num_disco TINYINT NOT NULL,
    cod_play SMALLINT NOT NULL,
    vezes_tocada SMALLINT,
    ultima_vez_tocada DATE,

    CONSTRAINT PK_faixa_playlist PRIMARY KEY(num_faixa, album, num_disco, cod_play),

    CONSTRAINT FK_faixa_playlist_faixa FOREIGN KEY (num_faixa, album, num_disco) REFERENCES Faixa(num_faixa, album, num_disco) ON DELETE CASCADE,

    CONSTRAINT FK_faixa_playlist_playlist FOREIGN KEY (cod_play) REFERENCES Playlist(cod_play)

) on FG_PLAYLISTS;

CREATE TABLE Interprete_Faixa (
    num_faixa TINYINT NOT NULL,
    album SMALLINT NOT NULL,
    num_disco TINYINT NOT NULL,
    cod_inter SMALLINT NOT NULL,

    CONSTRAINT PK_interprete_faixa PRIMARY KEY(num_faixa, album, num_disco, cod_inter),

    CONSTRAINT FK_interprete_faixa_faixa FOREIGN KEY (num_faixa, album, num_disco) REFERENCES Faixa(num_faixa, album, num_disco) ON DELETE CASCADE,

    CONSTRAINT FK_interprete_faixa_interprete FOREIGN KEY (cod_inter) REFERENCES Interprete(cod_inter)

) on FG_DADOS_GERAIS;

CREATE TABLE Compositor_Faixa (
    num_faixa TINYINT NOT NULL,
    album SMALLINT NOT NULL,
    num_disco TINYINT NOT NULL,
    cod_comp SMALLINT NOT NULL,

    CONSTRAINT PK_compositor_faixa PRIMARY KEY(num_faixa, album, num_disco, cod_comp),

    CONSTRAINT FK_compositor_faixa_faixa FOREIGN KEY (num_faixa, album, num_disco) REFERENCES Faixa(num_faixa, album, num_disco) ON DELETE CASCADE,

    CONSTRAINT FK_compositor_faixa_compositor FOREIGN KEY (cod_comp) REFERENCES Compositor(cod_comp)
    
) on FG_DADOS_GERAIS;