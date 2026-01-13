# Trabalho-Final-FBD

Trabalho final da disciplina Fundamentos de Bancos de Dados – 2025.2.

## Como executar o projeto

Criando a pasta que ficará os arquivos e ajustando permissões ( linux ):

```bash
mkdir -p ~/sqlserver/data
sudo chown -R 10001:0 ~/sqlserver
sudo chmod -R 775 ~/sqlserver
```

Criando o docker que roda o Sql Server:

```bash
docker run -d --name sqlserver
-e "ACCEPT_EULA=Y"
-e "MSSQL_SA_PASSWORD=SENHA"
-p 1433:1433
-v ~/sqlserver/data:/var/opt/mssql/data
mcr.microsoft.com/mssql/server:2022-latest
```

Criando o ambiente virtual:

```bash
python3 -m venv .venv
```

Ativando o ambiente virtual:

```bash
source .venv/bin/activate
```

Instalando os pacotes requeridos:

```bash
pip install -r requirements.txt
```
