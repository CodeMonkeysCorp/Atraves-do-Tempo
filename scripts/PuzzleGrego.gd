extends Node2D

const A = 3.0
const B = 4.0
const C_CORRETO = sqrt(A * A + B * B)

@onready var resposta_input = $Variaveis/Resposta
@onready var muito_bem_label = $Variaveis/Parabens
@onready var btn_avancar = $Variaveis/BtnAvancar
@onready var label_dica = $Variaveis/Dica

var tempo_inicio: float

func _ready():
	muito_bem_label.hide()
	btn_avancar.hide()
	label_dica.hide()
	tempo_inicio = Time.get_ticks_msec()

func _processar_resposta():
	var resposta_num = resposta_input.text.to_float()
	if abs(resposta_num - C_CORRETO) <= 0.1:
		muito_bem_label.show()
		btn_avancar.show()
		var tempo_total = (Time.get_ticks_msec() - tempo_inicio) / 1000.0
		GameManager.registrar_tempo("PuzzleGrecia", tempo_total)
		print("acerto")
		GameManager.tentativasGrecia += 1
		label_dica.hide()
	else:
		GameManager.tentativasGrecia += 1
		_mostrar_dica()
		muito_bem_label.hide()
		btn_avancar.hide()
		print("erro")

func _mostrar_dica():
	if GameManager.tentativasGrecia < 4 and GameManager.tentativasGrecia >= 2:
		label_dica.show()
		GameManager.dicasGrecia += 1
	if GameManager.tentativasGrecia >= 4:
		label_dica.text = "Dica 2: Também considere o B como a altura da coluna"
		GameManager.dicasGrecia += 1

func _on_btn_avancar_pressed() -> void:
	GameManager.goto("FaseIdadeMedia")

func _on_btn_confirmar_pressed() -> void:
	_processar_resposta()
