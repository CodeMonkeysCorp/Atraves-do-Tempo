# res://scripts/GameManager.gd
extends Node

var scenes := {
	"MainMenu":  "res://scenes/MainMenu.tscn",
	"FaseEgito": "res://scenes/FaseEgito.tscn",
	"FaseIdadeMedia": "res://scenes/Fase_Idade_Media.tscn",
	"Creditos":  "res://scenes/Creditos.tscn",
}

func goto(scene_name: String) -> void:
	var path: String = scenes.get(scene_name, "")
	if path == "":
		push_error("GameManager.goto: cena não mapeada -> %s" % scene_name)
		return
	var err := get_tree().change_scene_to_file(path)
	if err != OK:
		push_error("Falha ao carregar cena: %s (err=%s)" % [path, err])
