extends Area2D# BY Matheus Busemayer

@export var limites_fase := {
	"left": 0,
	"right": 1910,
	"top": 0,
	"bottom": 1080
}

@export var limites_puzzle := {
	"left": 0,
	"right": 29000,
	"top": 0,
	"bottom": 1080
}

@export var modo_retorno: bool = false
@export var camera_pos_destino_puzzle: Vector2 = Vector2(3400, 898)   # CÂMERA NO PUZZLE
@export var player_pos_destino_puzzle: Vector2 = Vector2(2850, 898)   # TELEPORTE DO PLAYER NO PUZZLE
@export var camera_pos_destino_fase: Vector2 = Vector2(1455, 898)     #  CÂMERA NA FASE
@export var player_pos_destino_fase: Vector2 = Vector2(1355, 898)     # TELEPORTE DO PLAYER NA FASE

var main_node: Node = null
var camera: Camera2D = null

func _ready():
	main_node = get_tree().get_current_scene()
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	camera = get_tree().get_root().find_child("Camera2D", true, false)
	if not camera:
		push_error("Nó Camera2D não encontrado!")

func _on_body_entered(body: Node):
	if not (body.is_in_group("player") or body.name == "player"):
		return

	var destino_player: Vector2
	var destino_camera: Vector2
	var limites: Dictionary
	var deve_seguir_destino: bool = true

	if modo_retorno:
		destino_player = player_pos_destino_fase
		destino_camera = camera_pos_destino_fase
		limites = limites_fase
		deve_seguir_destino = false
	else:
		destino_player = player_pos_destino_puzzle
		destino_camera = camera_pos_destino_puzzle
		limites = limites_puzzle
		deve_seguir_destino = true

	# CÂMERA
	if camera:
		camera.set_nova_posicao(destino_camera, deve_seguir_destino)
		camera.set_limites(limites)

	#  PLAYER
	if main_node and main_node.has_method("teleport_player"):
		main_node.teleport_player(destino_player, limites)
	else:
		push_warning("Nó principal não possui método teleport_player!")
