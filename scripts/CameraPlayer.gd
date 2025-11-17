extends Camera2D #BY Matheus Busemayer

@export var player: NodePath
@export var zoom_normal: Vector2 = Vector2(1.6, 1.6)
@export var zoom_olhar: Vector2 = Vector2(1, 1)

@export var limite_esquerda: int = 0
@export var limite_direita: int = 1910
@export var limite_cima: int = 0
@export var limite_baixo: int = 1080

var puzzle_zoom_ativo: bool = false
var nova_posicao: Vector2 = Vector2.ZERO 
var usando_nova_posicao: bool = false
const POSICAO_SUAVE_VELOCIDADE: float = 0.1 

func _ready():
	make_current()
	position_smoothing_enabled = false
	position_smoothing_speed = 5.0
	set_limites({
		"left": limite_esquerda,
		"right": limite_direita,
		"top": limite_cima,
		"bottom": limite_baixo
	})
	if player and get_node(player):
		nova_posicao = get_node(player).global_position
	else:
		nova_posicao = global_position

func _process(delta):
	var alvo_posicao: Vector2
	if usando_nova_posicao:
		alvo_posicao = nova_posicao
	elif player and get_node(player):
		alvo_posicao = get_node(player).global_position
	else:
		alvo_posicao = global_position
	global_position = global_position.lerp(alvo_posicao, POSICAO_SUAVE_VELOCIDADE)
	if puzzle_zoom_ativo:
		zoom = zoom.lerp(zoom_olhar, delta * 6)
	else:
		if Input.is_action_pressed("cancelar"):
			zoom = zoom.lerp(zoom_olhar, delta * 6)
		else:
			zoom = zoom.lerp(zoom_normal, delta * 6)

func set_nova_posicao(destino: Vector2, seguir_destino: bool = true):
	nova_posicao = destino
	usando_nova_posicao = seguir_destino
	if not seguir_destino:
		nova_posicao = global_position 

func definir_zoom_puzzle(ativo: bool):
	puzzle_zoom_ativo = ativo

func set_limites(novos_limites: Dictionary):
	if "left" in novos_limites:
		limit_left = novos_limites["left"]
	if "right" in novos_limites:
		limit_right = novos_limites["right"]
	if "top" in novos_limites:
		limit_top = novos_limites["top"]
	if "bottom" in novos_limites:
		limit_bottom = novos_limites["bottom"]
