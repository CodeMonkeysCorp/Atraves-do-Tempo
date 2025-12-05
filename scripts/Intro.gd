extends Control

@export var imagens_historia: Array[Texture2D] 

@export_file("*.tscn") var proxima_cena: String 

@onready var background: TextureRect = $Background

var index_atual: int = 0  # para saber em qual imagem estamos (começa na 0)

func _ready():
	if imagens_historia.size() > 0:
		background.texture = imagens_historia[0]
	else:
		print("ERRO: nenhuma imagem foi adicionada")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		avancar_historia()

func avancar_historia():
	index_atual += 1
	
	if index_atual < imagens_historia.size():
		background.texture = imagens_historia[index_atual]
	else:
		chamar_transicao()

func chamar_transicao():
	GameManager.concluir_fase("Intro")
