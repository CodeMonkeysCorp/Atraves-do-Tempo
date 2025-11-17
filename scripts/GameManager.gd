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


var scenes := {
	"MainMenu":  "res://scenes/MainMenu.tscn",
	"FaseEgito": "res://scenes/FaseEgito.tscn",
	"FaseGrecia": "res://scenes/FaseGrecia.tscn",
	"PuzzleGrego": "res://scenes/PuzzleGrego.tscn",
	"FaseIdadeMedia": "res://scenes/Fase_Idade_Media.tscn",
	"Creditos":  "res://scenes/Creditos.tscn",
	"Formulario": "res://scenes/Formulario.tscn",
	"DadosDaGameplay": "res://scenes/Dados_Gameplay.tscn",
}

func goto(scene_name: String) -> void:
	var path: String = scenes.get(scene_name, "")
	if path == "":
		push_error("GameManager.goto: cena não mapeada -> %s" % scene_name)
		return
	var err := get_tree().change_scene_to_file(path)
	if err != OK:
		push_error("Falha ao carregar cena: %s (err=%s)" % [path, err])
		
func registrar_tempo(nome_puzzle: String, tempo: float):
	tempos[nome_puzzle] = tempo
	print("Tempo registrado: ", nome_puzzle, " = ", tempo, "s")
