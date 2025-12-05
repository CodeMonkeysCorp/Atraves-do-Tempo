extends Control

@export_file("*.tscn") var cena_creditos: String 

func _input(event):
	if event.is_action_pressed("ui_accept"):
		ir_para_creditos()

func ir_para_creditos():
	GameManager.goto("Creditos")
