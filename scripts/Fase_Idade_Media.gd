extends Node2D #BY Matheus Busemayer

@onready var player = $player
@onready var camera = $player/Camera2D
@onready var tela_load = $TelaLoad

func teleport_player(destino: Vector2, limites: Dictionary):
	tela_load.show()
	await get_tree().create_timer(0.1).timeout  # pequena pausa para o fade aparecer
	
	# Teleporta o player e ajusta limites
	player.global_position = destino
	camera.set_limites(limites)
	print("Player teleportado e limites da câmera atualizados!")
	
	# Aguarda 2 segundos simulando o "carregamento"
	await get_tree().create_timer(0.8).timeout
	
	# Esconde novamente a tela de carregamento
	tela_load.hide()
