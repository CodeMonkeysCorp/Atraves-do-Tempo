extends Node2D

# --- CONFIGURAÇÕES DO NÍVEL ---
const A = 3.0  # altura do pilar
const B = 4.0  # comprimento da sombra
const C_CORRETO = sqrt(A * A + B * B)  # hipotenusa esperada (5.0)

# Referências aos nós
@onready var resposta_input = $Variaveis/Resposta
@onready var muito_bem_label = $Variaveis/Parabens
@onready var btn_avancar = $Variaveis/BtnAvancar

func _ready():
	# Esconde o "Muito Bem!" e o botão no início
	muito_bem_label.hide()
	btn_avancar.hide()

	# Conecta o sinal do LineEdit para detectar Enter
	resposta_input.connect("text_submitted", Callable(self, "_on_resposta_submitted"))

func _on_resposta_submitted(text):
	var resposta_num = text.to_float()

	# Verifica se a resposta é próxima o suficiente de 5.0
	if abs(resposta_num - C_CORRETO) <= 0.1:
		muito_bem_label.show()
		btn_avancar.show()
	else:
		muito_bem_label.hide()
		btn_avancar.hide()

func _on_btn_avancar_pressed() -> void:
	print("penis")
	GameManager.goto("FaseIdadeMedia")
