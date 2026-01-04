import customtkinter as ctk
from database import listar_playlists, listar_faixas_da_playlist, cria_playlist, obter_playlist_id, insere_faixa_playlist, deleta_faixa_playlist, deleta_playlist, listar_faixas_do_album, listar_albuns, obter_album_id
from datetime import date

class AbaPlaylists(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent)
        
        self.criar_cabecalho()
        
        self.criar_container_principal()
        
        self.criar_area_add_del_playlist()
        
        self.criar_area_adicionar_faixas()
        
        self.criar_area_remover_faixas()
        
        self.criar_area_lista()
        
        self.listar_nomes()
        
        self.resetar_combos()
        
        self.listar_tudo()
        
    def criar_cabecalho(self):
        self.label = ctk.CTkLabel(self, text="Gerenciar Playlists", font=("Arial", 20))
        self.label.pack(pady=20)

    def criar_container_principal(self):
        self.container_superior = ctk.CTkFrame(self, fg_color="transparent")
        self.container_superior.pack(pady=10, padx=20, fill="x")

    def criar_area_add_del_playlist(self):
        self.frame_criar_add_del = ctk.CTkFrame(self.container_superior)
        self.frame_criar_add_del.pack(side="left", padx=10, fill="both", expand=True)

        self.secao_criar = ctk.CTkFrame(self.frame_criar_add_del, fg_color="transparent")
        self.secao_criar.pack(fill="x")

        ctk.CTkLabel(self.secao_criar, text="Nova Playlist", font=("Arial", 14, "bold")).pack(pady=5)
        
        self.entry_nome_play = ctk.CTkEntry(self.secao_criar, placeholder_text="Nome da Playlist")
        self.entry_nome_play.pack(pady=5, padx=10, fill="x")

        self.btn_criar = ctk.CTkButton(self.secao_criar, text="Criar Playlist", command=self.criar_playlist)
        self.btn_criar.pack(pady=10, padx=10, fill="x")
        
        self.secao_apagar = ctk.CTkFrame(self.frame_criar_add_del, fg_color="transparent")
        self.secao_apagar.pack(fill="x")

        ctk.CTkLabel(self.secao_apagar, text="Apagar Playlist", font=("Arial", 14, "bold")).pack(pady=5)
        
        self.combo_playlist_total_del = ctk.CTkComboBox(self.secao_apagar, values=["Selecione a Playlist"], state="readonly")
        self.combo_playlist_total_del.pack(pady=5, padx=10, fill="x")

        self.btn_deletar_playlist = ctk.CTkButton(self.secao_apagar, text="Deletar Playlist", command=self.deletar_playlist_total)
        self.btn_deletar_playlist.pack(pady=10, padx=10, fill="x")
        
    def criar_area_adicionar_faixas(self):
        self.frame_add = ctk.CTkFrame(self.container_superior)
        self.frame_add.pack(side="left", padx=10, fill="both", expand=True)
        
        ctk.CTkLabel(self.frame_add, text="Adicionar Faixa(s)", font=("Arial", 14, "bold")).pack(pady=5)

        self.combo_playlist_add_faixa = ctk.CTkComboBox(self.frame_add, values=["Selecione a Playlist"], state="readonly")
        self.combo_playlist_add_faixa.pack(pady=5, padx=10, fill="x")
        
        self.combo_album = ctk.CTkComboBox(self.frame_add, values=["Selecione o Álbum"], state="readonly", command=self.ao_selecionar_album_add)
        self.combo_album.pack(pady=5, padx=10, fill="x")
        
        self.frame_lista_faixas = ctk.CTkScrollableFrame(self.frame_add, height=100, label_text="Faixas Disponíveis", label_font=("Arial", 12, "bold"))
        self.frame_lista_faixas.pack(pady=5, padx=10, fill="x")
        
        self.checkboxes_faixas_add = []
        
        self.btn_vincular = ctk.CTkButton(self.frame_add, text="Vincular Faixa(s)", command=self.vincular_faixa_a_playlist)
        self.btn_vincular.pack(pady=10, padx=10, fill="x")
        
    def criar_area_remover_faixas(self):
        self.frame_del = ctk.CTkFrame(self.container_superior)
        self.frame_del.pack(side="left", padx=10, fill="both", expand=True)
        
        ctk.CTkLabel(self.frame_del, text="Deletar Faixa(s)", font=("Arial", 14, "bold")).pack(pady=5)
        
        self.combo_playlist_del_faixa = ctk.CTkComboBox(self.frame_del, values=["Selecione a Playlist"], state="readonly", command=self.ao_selecionar_playlist_del)
        self.combo_playlist_del_faixa.pack(pady=5, padx=10, fill="x")
        
        self.frame_lista_faixas_del = ctk.CTkScrollableFrame(self.frame_del, height=100, label_text="Faixas Disponíveis", label_font=("Arial", 12, "bold"))
        self.frame_lista_faixas_del.pack(pady=5, padx=10, fill="x")
        
        self.checkboxes_faixas_del = []
        
        self.btn_remover = ctk.CTkButton(self.frame_del, text="Remover Faixa(s)", command=self.remover_faixa_da_playlist)
        self.btn_remover.pack(pady=10, padx=10, fill="x")
        
    def criar_area_lista(self):
        self.frame_lista = ctk.CTkFrame(self.container_superior)
        self.frame_lista.pack(side="left", padx=10, fill="both", expand=True)
        
        ctk.CTkLabel(self.frame_lista, text="Playlists e suas Faixas", font=("Arial", 14, "bold")).pack(pady=5)

        self.lista = ctk.CTkTextbox(self.frame_lista, width=650, height=250)
        self.lista.pack(pady=10, padx=20, fill="both", expand=True)

    def criar_playlist(self):        
        nome = self.entry_nome_play.get()
        
        if not nome:
            return

        cria_playlist(nome, date.today(),)
        self.entry_nome_play.delete(0, "end")
        
        self.limpar_lista_checkboxes(self.checkboxes_faixas_add)
        self.limpar_lista_checkboxes(self.checkboxes_faixas_del)
        
        self.listar_nomes()
        
        self.resetar_combos()
        
        self.listar_tudo()
            
    def deletar_playlist_total(self):
        playlist_nome = self.combo_playlist_total_del.get()
        
        if playlist_nome == "Selecione a Playlist":
            return
        
        playlist_id = obter_playlist_id(playlist_nome)
        
        deleta_playlist(playlist_id)
        
        self.limpar_lista_checkboxes(self.checkboxes_faixas_add)
        self.limpar_lista_checkboxes(self.checkboxes_faixas_del)
        
        self.listar_nomes()
        
        self.resetar_combos()
            
        self.listar_tudo()
        
    def ao_selecionar_album_add(self, escolha):
        self.limpar_lista_checkboxes(self.checkboxes_faixas_add)

        if escolha == "Selecione o Álbum":
            return

        album_id = obter_album_id(escolha)
        
        faixas = listar_faixas_do_album(album_id)

        for faixa in faixas:
            cb = ctk.CTkCheckBox(
                self.frame_lista_faixas,
                text=f"{faixa['num_disco']}-{faixa['num_faixa']} {faixa['descricao']}")
            
            cb.faixa_info = faixa
            cb.pack(pady=2, padx=5, anchor="w")
            
            self.checkboxes_faixas_add.append(cb)
            
    def vincular_faixa_a_playlist(self):
        playlist_nome = self.combo_playlist_add_faixa.get()
        album_nome = self.combo_album.get()

        if playlist_nome == "Selecione a Playlist" or album_nome == "Selecione o Álbum":
            return

        playlist_id = obter_playlist_id(playlist_nome)
        album_id = obter_album_id(album_nome)

        if not playlist_id or not album_id:
            return

        for cb in self.checkboxes_faixas_add:
            if cb.get():
                faixa = cb.faixa_info

                insere_faixa_playlist(
                    num_faixa=faixa["num_faixa"],
                    album=album_id,
                    num_disco=faixa["num_disco"],
                    id_play=playlist_id)

        self.ao_selecionar_album_add(album_nome)
        
        if self.combo_playlist_del_faixa.get() == playlist_nome:
            self.ao_selecionar_playlist_del(playlist_nome)

        self.listar_tudo()  
        
    def ao_selecionar_playlist_del(self, escolha):
        self.limpar_lista_checkboxes(self.checkboxes_faixas_del)

        if escolha == "Selecione a Playlist":
            return
        
        playlist_id = obter_playlist_id(escolha)
        
        faixas = listar_faixas_da_playlist(playlist_id)
        
        for faixa in faixas:
            texto_exibicao = f"{faixa['num_faixa']} - {faixa['descricao']}"
            
            cb = ctk.CTkCheckBox(
                self.frame_lista_faixas_del, 
                text=texto_exibicao,
                font=("Arial", 14, "bold"))
            
            cb.faixa_info = faixa
            cb.pack(pady=2, padx=5, anchor="w")
            
            self.checkboxes_faixas_del.append(cb)

    def remover_faixa_da_playlist(self):
        playlist_nome = self.combo_playlist_del_faixa.get()
        
        if playlist_nome == "Selecione a Playlist":
            return
        
        playlist_id = obter_playlist_id(playlist_nome)
        
        for cb in self.checkboxes_faixas_del:
            if cb.get():
                faixa = cb.faixa_info

                deleta_faixa_playlist(
                    num_faixa=faixa["num_faixa"],
                    album=faixa["album"],
                    num_disco=faixa["num_disco"],
                    id_play=playlist_id)

        self.ao_selecionar_playlist_del(playlist_nome)
        
        self.listar_tudo()
    
    def listar_nomes(self):
        playlists = listar_playlists()
        albuns = listar_albuns()
        
        playlists_nomes = ["Selecione a Playlist"] + [p["nome"] for p in playlists]
        albuns_nomes = ["Selecione o Álbum"] + [a["descricao"] for a in albuns]

        self.combo_playlist_add_faixa.configure(values=playlists_nomes)
        self.combo_playlist_del_faixa.configure(values=playlists_nomes)
        self.combo_playlist_total_del.configure(values=playlists_nomes)
        self.combo_album.configure(values=albuns_nomes)

        

    def listar_tudo(self):
        dados = listar_playlists()
        self.lista.delete("0.0", "end")
        
        for playlist in dados:
            cod = playlist['cod_play']
            nome = playlist['nome']
            data = playlist['data_criacao']
            tempo = playlist['tempo_exec']
            
            self.lista.insert("end", f"ID: {cod} | NOME: {nome} | CRIAÇÃO: {data} | DURAÇÃO: {tempo}\n")
            
            faixas = listar_faixas_da_playlist(cod)
            
            if not faixas:
                self.lista.insert("end", "\t(Nenhuma faixa cadastrada)\n")
            else:
                for faixa in faixas:
                    f_num = faixa['num_faixa']
                    f_desc = faixa['descricao']
                    f_disc = faixa['num_disco']
                    
                    self.lista.insert("end", f"\tNUM: {f_num} | {f_desc} (DISCO: {f_disc})\n")
                    
    def limpar_lista_checkboxes(self, lista_checkboxes):
        for cb in lista_checkboxes:
            cb.destroy()
        lista_checkboxes.clear()

    def resetar_combos(self):
        self.combo_playlist_total_del.set("Selecione a Playlist")
        self.combo_playlist_add_faixa.set("Selecione a Playlist")
        self.combo_playlist_del_faixa.set("Selecione a Playlist")
        self.combo_album.set("Selecione o Álbum")