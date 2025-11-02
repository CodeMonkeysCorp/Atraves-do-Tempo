extends Control

@onready var dialogo          = $VBoxContainer/Dialogo
@onready var lbl_problema     = $VBoxContainer/Puzzle/LabelProblema
@onready var entrada_resposta = $VBoxContainer/Puzzle/HBoxContainer/EntradaResposta
@onready var btn_confirmar    = $VBoxContainer/Puzzle/HBoxContainer/BtnConfirmar
@onready var lbl_feedback     = $VBoxContainer/Puzzle/LabelFeedback
@onready var btn_avancar      = $VBoxContainer/Puzzle/BtnAvancar
@onready var tela_load        = $TelaLoad

func _ready():
	if tela_load:
		tela_load.hide()
	lbl_feedback.hide()
	btn_avancar.disabled = true

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
	else:
		lbl_feedback.text = "Tente novamente!"
		lbl_feedback.show()

func _on_btn_avancar_pressed() -> void:
	tela_load.show()
	await get_tree().create_timer(0.9).timeout
	tela_load.hide()
	GameManager.goto("FaseGrecia")
