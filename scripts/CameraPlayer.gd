extends Camera2D

@export var player: NodePath
@export var zoom_normal: Vector2 = Vector2(1.2, 1.2)
@export var zoom_olhar: Vector2 = Vector2(0.75, 0.75)
@export var limite_esquerda: int = 0
@export var limite_direita: int = 1910
@export var limite_cima: int = 0
@export var limite_baixo: int = 1080

func _ready():
	make_current()  # ativa esta câmera
	position_smoothing_enabled = false
	position_smoothing_speed = 5.0
	limit_left = limite_esquerda
	limit_right = limite_direita
	limit_top = limite_cima
	limit_bottom = limite_baixo

func _process(delta):
	if player:
		var alvo = get_node(player)
		global_position = alvo.global_position

	# Zoom controlado por input
	if Input.is_action_pressed("cancelar"):
		zoom = zoom.lerp(zoom_olhar, delta * 6) # zoom out suave
	else:
		zoom = zoom.lerp(zoom_normal, delta * 6) # volta pro normal
