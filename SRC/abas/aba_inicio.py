import customtkinter as ctk

class AbaInicio(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent)
        
        self.label = ctk.CTkLabel(self, text="Seja bem vindo(a) ao BDSpotPer", font=("Arial", 20))
        self.label.pack(pady=20)
        
        self.label = ctk.CTkLabel(self, text="O aplicativo que organiza sua coleção de músicas!", font=("Arial", 15))
        self.label.pack(pady=0)