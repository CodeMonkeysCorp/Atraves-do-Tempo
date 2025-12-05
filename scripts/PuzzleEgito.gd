extends Control

@onready var dialogo          = $VBoxContainer/Dialogo
@onready var lbl_problema     = $VBoxContainer/Puzzle/LabelProblema
@onready var entrada_resposta = $VBoxContainer/Puzzle/HBoxContainer/EntradaResposta
@onready var btn_confirmar    = $VBoxContainer/Puzzle/HBoxContainer/BtnConfirmar
@onready var lbl_feedback     = $VBoxContainer/Puzzle/LabelFeedback
@onready var btn_avancar      = $VBoxContainer/Puzzle/BtnAvancar
@onready var tela_load        = $TelaLoad
@onready var label_dica       = $VBoxContainer/Puzzle/LabelDica

var tempo_inicio: float
var dica_1 = false
var dica_2 = false
var dica_3 = false

func _ready():
	if tela_load:
		tela_load.hide()
	lbl_feedback.hide()
	btn_avancar.disabled = true
	tempo_inicio = Time.get_ticks_msec()

func _eh_equivalente(resposta: String, alvo: String) -> bool:
	if not resposta.contains("/"):
		return false
	var partes_resposta = resposta.split("/")
	var partes_alvo = alvo.split("/")
	if partes_resposta.size() != 2 or partes_alvo.size() != 2:
		return false
	var num_r = partes_resposta[0].to_int()
	var den_r = partes_resposta[1].to_int()
	var num_a = partes_alvo[0].to_int()
	var den_a = partes_alvo[1].to_int()
	if den_r == 0 or den_a == 0:
		return false
	return num_r * den_a == num_a * den_r

func _on_btn_confirmar_pressed() -> void:
	var resposta = entrada_resposta.text.strip_edges()
	if _eh_equivalente(resposta, "5/6"):
		lbl_feedback.text = "Muito bem!"
		lbl_feedback.show()
		btn_avancar.disabled = false
		GameManager.contar_dicas_Egito(dica_1, dica_2, dica_3)
		print(dica_1, dica_2, dica_3)
		GameManager.tentativasEgito += 1
		var tempo_total = (Time.get_ticks_msec() - tempo_inicio) / 1000.0
		GameManager.registrar_tempo("PuzzleEgito", tempo_total)
	else:
		lbl_feedback.text = "Tente novamente!"
		lbl_feedback.show()
		GameManager.tentativasEgito += 1
		_mostrar_dica()

func _mostrar_dica():
	if GameManager.tentativasEgito < 4 and GameManager.tentativasEgito >= 2:
		dica_1 = true
		label_dica.show()
		
	if GameManager.tentativasEgito < 6 and GameManager.tentativasEgito >= 4:
		dica_2 = true
		label_dica.text = "Dica 2: Use o Mínimo Multiplo Comum das bases nas frações"
		
	if GameManager.tentativasEgito >= 6:
		dica_3 = true
		label_dica.text = "Dica 3: Transforme as frações para Sextos. EX: 1/2 = 3/6"

func _on_btn_avancar_pressed() -> void:
	#tela_load.show()
	#await get_tree().create_timer(0.9).timeout
	#tela_load.hide()
	GameManager.concluir_fase("FaseEgito")
