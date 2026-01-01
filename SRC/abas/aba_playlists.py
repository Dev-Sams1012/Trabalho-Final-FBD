import customtkinter as ctk
from database import listar_playlists, listar_faixas_da_playlist

class AbaPlaylists(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent)
        
        self.label = ctk.CTkLabel(self, text="Gerenciar Playlists", font=("Arial", 20))
        self.label.pack(pady=20)

        self.btn = ctk.CTkButton(self, text="Atualizar Lista", command=self.listar)
        self.btn.pack(pady=10)

        self.lista = ctk.CTkTextbox(self, width=450, height=200)
        self.lista.pack(pady=10)

    def listar(self):
        dados = listar_playlists()
        self.lista.delete("0.0", "end")
        
        for playlist in dados:
            cod = playlist['cod_play']
            nome = playlist['nome']
            data = playlist['data_criacao']
            
            self.lista.insert("end", f"ID: {cod} | NOME: {nome} | CRIAÇÃO: {data}\n")
            
            faixas = listar_faixas_da_playlist(cod)
            
            if not faixas:
                self.lista.insert("end", "\t(Nenhuma faixa cadastrada)\n")
            else:
                for faixa in faixas:
                    f_num = faixa['num_faixa']
                    f_desc = faixa['descricao']
                    f_disc = faixa['num_disco']
                    
                    self.lista.insert("end", f"\tNUM: {f_num} | {f_desc} (DISCO: {f_disc})\n")