CREATE DATABASE BDSpotPer
ON PRIMARY (
    NAME = 'BDSpotPer_Primary',
    FILENAME = '/var/opt/mssql/data/BDSpotPer_Primary.mdf'
),
FILEGROUP FG_DADOS_GERAIS (
    NAME = 'BDSpotPer_Dados1',
    FILENAME = '/var/opt/mssql/data/BDSpotPer_Dados1.ndf'
),
(
    NAME = 'BDSpotPer_Dados2',
    FILENAME = '/var/opt/mssql/data/BDSpotPer_Dados2.ndf'
),
FILEGROUP FG_PLAYLISTS (
    NAME = 'BDSpotPer_Playlists',
    FILENAME = '/var/opt/mssql/data/BDSpotPer_Playlists.ndf'
)
LOG ON (
    NAME = 'BDSpotPer_Log',
    FILENAME = '/var/opt/mssql/data/BDSpotPer_Log.ldf'
);
GO

-- caminho padrão referente ao docker com sql server no linux.
