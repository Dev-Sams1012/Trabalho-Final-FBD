import customtkinter as ctk
from database import listar_interpretes

class Abainterpretes(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent)
        
        self.label = ctk.CTkLabel(self, text="Gerenciar interpretees", font=("Arial", 20))
        self.label.pack(pady=20)

        self.btn = ctk.CTkButton(self, text="Atualizar Lista", command=self.listar)
        self.btn.pack(pady=10)

        self.lista = ctk.CTkTextbox(self, width=300, height=200)
        self.lista.pack(pady=10)

    def listar(self):
        dados = listar_interpretes()
        self.lista.delete("0.0", "end")
        
        for interprete in dados:
            cod = interprete['cod_inter']
            nome = interprete['nome']
            tipo = interprete['tipo']
            
            self.lista.insert("end", f"ID: {cod} | NOME: {nome} ({tipo})\n")