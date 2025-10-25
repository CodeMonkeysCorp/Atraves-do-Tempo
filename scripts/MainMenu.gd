extends Node2D

@onready var btn_jogar    = $MenuBox/BtnJogar
@onready var btn_opcoes    = $MenuBox/BtnOpcoes
@onready var btn_creditos = $MenuBox/BtnCreditos
@onready var btn_sair     = $MenuBox/BtnSair

func _ready() -> void:
	# Conectando os botões às funções
	btn_jogar.pressed.connect(_ir_jogar)
	btn_opcoes.pressed.connect(_ir_opcoes)
	btn_creditos.pressed.connect(_ir_creditos)
	btn_sair.pressed.connect(_ir_sair)

func _ir_jogar() -> void:
	GameManager.goto("FaseEgito")

func _ir_opcoes() -> void:
	GameManager.goto("Opcoes")

func _ir_creditos() -> void:
	print("oi")
	GameManager.goto("Creditos")

func _ir_sair() -> void:
	get_tree().quit()
