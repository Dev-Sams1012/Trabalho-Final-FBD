import customtkinter as ctk
from database import listar_compositores

class AbaCompositores(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent)
        
        self.label = ctk.CTkLabel(self, text="Gerenciar Compositores", font=("Arial", 20))
        self.label.pack(pady=20)

        self.btn = ctk.CTkButton(self, text="Atualizar Lista", command=self.listar)
        self.btn.pack(pady=10)

        self.lista = ctk.CTkTextbox(self, width=420, height=200)
        self.lista.pack(pady=10)

    def listar(self):
        dados = listar_compositores()
        self.lista.delete("0.0", "end")
        
        for compositor in dados:
            cod = compositor['cod_comp']
            nome = compositor['nome']
            nasc = compositor['local_nasc']
            per = compositor['periodo_musical']
            
            self.lista.insert("end", f"ID: {cod} | NOME: {nome} (NASCIMENTO: {nasc} | {per})\n")