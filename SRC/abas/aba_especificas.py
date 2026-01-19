import customtkinter as ctk
from database import listar_albuns_preco_acima_media, compositor_mais_faixas, listar_playlists_concerto_barroco, listar_gravadora_maior_qtd_Dvorack

class AbaEspecificas(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent)

        self.criar_cabecalho()
        self.criar_container_principal()
        self.criar_botoes()
        self.criar_area_resultado()

    def criar_cabecalho(self):
        self.label = ctk.CTkLabel(self, text="Consultas Específicas", font=("Arial", 20))
        self.label.pack(pady=20)

    def criar_container_principal(self):
        self.container = ctk.CTkFrame(self, fg_color="transparent")
        self.container.pack(padx=20, pady=10)

    def criar_botoes(self):
        largura_btn = 280

        self.linha1 = ctk.CTkFrame(self.container, fg_color="transparent")
        self.linha1.pack(pady=5)

        self.btn1 = ctk.CTkButton(
            self.linha1,
            text="Álbuns com preço acima da média",
            width=largura_btn,
            command=self.listar_consulta_1
        )
        self.btn1.pack(side="left", padx=10)

        self.btn2 = ctk.CTkButton(
            self.linha1,
            text="Gravadora com mais playlists (Dvorack)",
            width=largura_btn,
            command=self.listar_consulta_2
        )
        self.btn2.pack(side="left", padx=10)

        self.linha2 = ctk.CTkFrame(self.container, fg_color="transparent")
        self.linha2.pack(pady=5)

        self.btn3 = ctk.CTkButton(
            self.linha2,
            text="Compositor com mais faixas em playlists",
            width=largura_btn,
            command=self.listar_consulta_3
        )
        self.btn3.pack(side="left", padx=10)

        self.btn4 = ctk.CTkButton(
            self.linha2,
            text="Playlists somente com Concerto Barroco",
            width=largura_btn,
            command=self.listar_consulta_4
        )
        self.btn4.pack(side="left", padx=10)

    def criar_area_resultado(self):
        self.resultado = ctk.CTkTextbox(self, width=300, height=200)
        self.resultado.pack(pady=10)

    def limpar_resultado(self):
        self.resultado.delete("1.0", "end")

    def listar_consulta_1(self):
        self.limpar_resultado()
        dados = listar_albuns_preco_acima_media()
        for dado in dados:
            album = dado['descricao']
            preco = dado['preco_compra']
            self.resultado.insert("end", f"{album} - R$ {preco}\n")

    def listar_consulta_2(self):
        self.limpar_resultado()
        dados = listar_gravadora_maior_qtd_Dvorack()
        for dado in dados:
            nome = dado['nome_gravadora']
            total = dado['total_playlists']
            self.resultado.insert("end", f"{nome} - {total} playlists\n")

    def listar_consulta_3(self):
        self.limpar_resultado()
        dados = compositor_mais_faixas()
        for dado in dados:
            nome = dado['nome']
            total = dado['total_faixas']
            self.resultado.insert("end", f"{nome} - {total} faixas\n")

    def listar_consulta_4(self):
        self.limpar_resultado()
        dados = listar_playlists_concerto_barroco()
        for dado in dados:
            cod_play = dado['cod_play']
            nome = dado['nome']
            self.resultado.insert("end", f"{cod_play} - {nome}\n")