# res://scripts/GameManager.gd
extends Node
# Dados de Gameplay
var tentativasEgito = 0
var tentativasGrecia = 0
var tentativasIdadeMedia = 0

var dicasEgito = 0
var dicasGrecia = 0
var dicasIdadeMedia = 0

var tempoEgito: float = 0.0
var tempoGrecia: float = 0.0
var tempoIdadeMedia: float = 0.0

var tempos = {}  # aqui vão ficar os tempos dos puzzles

var ultima_fase_concluida: String = ""  # variável para armazenar de onde o jogador veio

var scenes := {
	"MainMenu":  "res://scenes/MainMenu.tscn",
	"FaseEgito": "res://scenes/FaseEgito.tscn",
	"PuzzleEgito": "res://scenes/PuzzleEgito.tscn",
	"FaseGrecia": "res://scenes/FaseGrecia.tscn",
	"PuzzleGrego": "res://scenes/PuzzleGrego.tscn",
	"FaseIdadeMedia": "res://scenes/Fase_Idade_Media.tscn",
	"PuzzleMedieval": "res://scenes/Puzzle_Medieval.tscn",
	"Creditos":  "res://scenes/Creditos.tscn",
	"Formulario": "res://scenes/Formulario.tscn",
	"DadosDaGameplay": "res://scenes/Dados_Gameplay.tscn",
	"Intro": "res://scenes/Intro.tscn",
	"Transição": "res://scenes/Transição.tscn",
	"CenaFinal": "res://scenes/CenaFinal.tscn"
}

func goto(scene_name: String) -> void:
	var path: String = scenes.get(scene_name, "")
	if path == "":
		push_error("GameManager.goto: cena não mapeada -> %s" % scene_name)
		return
	var err := get_tree().change_scene_to_file(path)
	if err != OK:
		push_error("Falha ao carregar cena: %s (err=%s)" % [path, err])
		
func concluir_fase(nome_fase_atual: String):
	ultima_fase_concluida = nome_fase_atual
	goto("Transição")

func registrar_tempo(nome_puzzle: String, tempo: float):
	tempos[nome_puzzle] = tempo
	print("Tempo registrado: ", nome_puzzle, " = ", tempo, "s")
	
func contar_dicas_Egito(v1: bool, v2: bool, v3: bool):
	if v1: dicasEgito += 1
	if v2: dicasEgito += 1
	if v3: dicasEgito += 1
	
func contar_dicas_Grecia(v1: bool, v2: bool):
	if v1: dicasGrecia += 1
	if v2: dicasGrecia += 1

func contar_dicas_IdadeMedia(v1: bool, v2: bool):
	if v1: dicasIdadeMedia += 1
	if v2: dicasIdadeMedia += 1
	
func reset_dados():
	tentativasEgito = 0
	tentativasGrecia = 0
	tentativasIdadeMedia = 0
	
	dicasEgito = 0
	dicasGrecia = 0
	dicasIdadeMedia = 0
	
	tempoEgito = 0.0
	tempoGrecia = 0.0
	tempoIdadeMedia = 0.0
	tempos.clear()
