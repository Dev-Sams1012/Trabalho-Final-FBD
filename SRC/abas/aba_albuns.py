import customtkinter as ctk
from database import listar_albuns, listar_faixas_do_album

class AbaAlbuns(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent)
        
        self.label = ctk.CTkLabel(self, text="Gerenciar Álbuns", font=("Arial", 20))
        self.label.pack(pady=20)

        self.btn = ctk.CTkButton(self, text="Atualizar Lista", command=self.listar)
        self.btn.pack(pady=10)

        self.lista = ctk.CTkTextbox(self, width=450, height=200)
        self.lista.pack(pady=10)

    def listar(self):
        albuns = listar_albuns()
        self.lista.delete("0.0", "end")
        
        for album in albuns:
            cod = album['cod_album']
            desc = album['descricao']
            meio = album['meio_fisico']
            data = album['data_grav']
            grav = album['gravadora']
            
            self.lista.insert("end", f"ID: {cod} | {desc} ({grav} | {meio} | {data})\n")
            
            faixas = listar_faixas_do_album(cod)
            
            if not faixas:
                self.lista.insert("end", "\t(Nenhuma faixa cadastrada)\n")
            else:
                for faixa in faixas:
                    f_num = faixa['num_faixa']
                    f_desc = faixa['descricao']
                    f_disc = faixa['num_disco']
                    
                    self.lista.insert("end", f"\tNUM: {f_num} | {f_desc} (DISCO: {f_disc})\n")