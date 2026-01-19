import customtkinter as ctk
from database import listar_albuns_preco_acima_media

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
        self.container.pack(padx=20, fill="both", expand=True)

    def criar_botoes(self):
        self.linha1 = ctk.CTkFrame(self.container, fg_color="transparent")
        self.linha1.pack(fill="x", pady=5)

        self.btn1 = ctk.CTkButton(self.linha1, text="Álbuns com preço acima da média", command=self.listar_consulta_1)
        self.btn1.pack(side="left", padx=10, fill="x", expand=True)

        self.btn2 = ctk.CTkButton(self.linha1, text="Gravadora com mais playlists (Dvorack)", command=self.listar_consulta_2)
        self.btn2.pack(side="left", padx=10, fill="x", expand=True)

        self.linha2 = ctk.CTkFrame(self.container, fg_color="transparent")
        self.linha2.pack(fill="x", pady=5)

        self.btn3 = ctk.CTkButton(self.linha2, text="Compositor com mais faixas", command=self.listar_consulta_3)
        self.btn3.pack(side="left", padx=10, fill="x", expand=True)

        self.btn4 = ctk.CTkButton(self.linha2, text="Playlists só com Concerto Barroco", command=self.listar_consulta_4)
        self.btn4.pack(side="left", padx=10, fill="x", expand=True)

    def criar_area_resultado(self):
        self.resultado = ctk.CTkTextbox(self, height=260)
        self.resultado.pack(padx=20, pady=15, fill="both", expand=True)
        
    def limpar_resultado(self):
        self.resultado.delete("1.0", "end")

    def listar_consulta_1(self):
        self.limpar_resultado()
        dados = listar_albuns_preco_acima_media()
        for albuns in dados:
            album = albuns['descricao']
            preco = albuns['preco_compra']
            self.resultado.insert("end", f"{album} - R$ {preco}\n")

    def listar_consulta_2(self):
        self.escrever_resultado("Resultado da consulta 2")

    def listar_consulta_3(self):
        self.escrever_resultado("Resultado da consulta 3")

    def listar_consulta_4(self):
        self.escrever_resultado("Resultado da consulta 4")
