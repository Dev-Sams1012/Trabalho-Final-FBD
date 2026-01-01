import customtkinter as ctk
from abas.aba_inicio import AbaInicio
from abas.aba_albuns import AbaAlbuns
from abas.aba_playlists import AbaPlaylists
from abas.aba_compositores import AbaCompositores
from abas.aba_interpretes import Abainterpretes

ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("green")

class App(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("SpotPer")
        self.geometry("800x600")

        self.tabview = ctk.CTkTabview(self)
        self.tabview.pack(fill="both", expand=True, padx=20, pady=20)

        self.tabview.add("Início")
        self.tabview.add("Álbuns")
        self.tabview.add("Playlists")
        self.tabview.add("Compositores")
        self.tabview.add("Intérpretes")

        self.aba_1 = AbaInicio(self.tabview.tab("Início"))
        self.aba_1.pack(fill="both", expand=True)
        
        self.aba_2 = AbaAlbuns(self.tabview.tab("Álbuns"))
        self.aba_2.pack(fill="both", expand=True)
        
        self.aba_3 = AbaPlaylists(self.tabview.tab("Playlists"))
        self.aba_3.pack(fill="both", expand=True)
        
        self.aba_4 = AbaCompositores(self.tabview.tab("Compositores"))
        self.aba_4.pack(fill="both", expand=True)
        
        self.aba_5 = Abainterpretes(self.tabview.tab("Intérpretes"))
        self.aba_5.pack(fill="both", expand=True)

if __name__ == "__main__":
    app = App()
    app.mainloop()