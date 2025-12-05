extends Node2D

@onready var btn_jogar    = $MenuBox/BtnJogar
@onready var btn_creditos = $MenuBox/BtnCreditos
@onready var btn_sair     = $MenuBox/BtnSair

func _ready() -> void:
	# Conectando os botões às funções
	btn_jogar.pressed.connect(_ir_jogar)
	btn_creditos.pressed.connect(_ir_creditos)
	btn_sair.pressed.connect(_ir_sair)
	Musica.tocar("Egito")

func _ir_jogar() -> void:
	GameManager.goto("Intro")

func _ir_opcoes() -> void:
	GameManager.goto("Opcoes")

func _ir_creditos() -> void:
	print("oi")
	GameManager.goto("Creditos")

func _ir_sair() -> void:
	get_tree().quit()

func _on_btn_feed_back_pressed() -> void:
	GameManager.goto("Formulario")
