extends Control

@onready var dialogo          = $VBoxContainer/Dialogo
@onready var lbl_problema     = $VBoxContainer/Puzzle/LabelProblema
@onready var entrada_resposta = $VBoxContainer/Puzzle/HBoxContainer/EntradaResposta
@onready var btn_confirmar    = $VBoxContainer/Puzzle/HBoxContainer/BtnConfirmar
@onready var lbl_feedback     = $VBoxContainer/Puzzle/LabelFeedback
@onready var btn_avancar      = $VBoxContainer/Puzzle/BtnAvancar

@onready var Dica1 = $Dica1
@onready var Dica2 = $Dica2
@onready var Dica3 = $Dica3

var erros = 0

func _ready():
	lbl_feedback.hide()
	btn_avancar.disabled = true
	Dica1.hide()
	Dica2.hide()
	Dica3.hide()


# --- Função auxiliar para checar frações equivalentes ---
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
	print(resposta)
	
	if _eh_equivalente(resposta, "5/6"):
		lbl_feedback.text = "Muito bem!"
		lbl_feedback.show()
		btn_avancar.disabled = false
	else:
		erros += 1
		lbl_feedback.text = "Tente novamente!"
		lbl_feedback.show()
		_mostrar_dica()
		

func _mostrar_dica():
	if erros == 1:
		Dica1.show()
	elif erros == 2:
		Dica2.show()
	elif erros >= 3:
		Dica3.show()


func _on_btn_avancar_pressed() -> void:
	GameManager.goto("FaseIdadeMedia")
	print("Finalizou Fase 1 - Egito")
