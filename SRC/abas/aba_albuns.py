import customtkinter as ctk
from database import listar_albuns

class AbaAlbuns(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent)
        
        self.label = ctk.CTkLabel(self, text="Gerenciar Álbuns", font=("Arial", 20))
        self.label.pack(pady=20)

        self.btn = ctk.CTkButton(self, text="Atualizar Lista", command=self.listar)
        self.btn.pack(pady=10)

        self.lista = ctk.CTkTextbox(self, width=400, height=200)
        self.lista.pack(pady=10)

    def listar(self):
        dados = listar_albuns()
        self.lista.delete("0.0", "end")
        
        for album in dados:
            cod = album['cod_album']
            desc = album['descricao']
            meio = album['meio_fisico']
            data = album['data_grav']
            grav = album['gravadora']
            
            self.lista.insert("end", f"ID: {cod} | {desc} ({grav} | {meio} | {data})\n")