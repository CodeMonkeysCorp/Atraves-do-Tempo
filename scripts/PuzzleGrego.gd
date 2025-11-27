extends Node2D

const A = 3.0
const B = 4.0
const C_CORRETO = sqrt(A * A + B * B)

@onready var resposta_input = $Variaveis/Resposta
@onready var muito_bem_label = $Variaveis/Parabens
@onready var btn_avancar = $Variaveis/BtnAvancar
@onready var label_dica = $Variaveis/Dica
@onready var erro_txt = $Variaveis/TenteNovamente

var tempo_inicio: float
var dica_1 = false
var dica_2 = false

func _ready():
	muito_bem_label.hide()
	btn_avancar.hide()
	label_dica.hide()
	erro_txt.hide()
	tempo_inicio = Time.get_ticks_msec()

func _processar_resposta():
	erro_txt.hide()
	var resposta_num = resposta_input.text.to_float()
	if abs(resposta_num - C_CORRETO) <= 0.1:
		muito_bem_label.show()
		btn_avancar.show()
		var tempo_total = (Time.get_ticks_msec() - tempo_inicio) / 1000.0
		GameManager.registrar_tempo("PuzzleGrecia", tempo_total)
		print("acerto")
		GameManager.contar_dicas_Grecia(dica_1, dica_2)
		GameManager.tentativasGrecia += 1
		label_dica.hide()
	else:
		GameManager.tentativasGrecia += 1
		_mostrar_dica()
		erro_txt.show()
		muito_bem_label.hide()
		btn_avancar.hide()
		print("erro")

func _mostrar_dica():
	if GameManager.tentativasGrecia < 4 and GameManager.tentativasGrecia >= 2:
		label_dica.show()
		dica_1 = true
	if GameManager.tentativasGrecia >= 4:
		label_dica.text = "Dica 2: Também considere o B como a altura da coluna"
		dica_2 = true

func _on_btn_avancar_pressed() -> void:
	GameManager.goto("FaseIdadeMedia")

func _on_btn_confirmar_pressed() -> void:
	_processar_resposta()
