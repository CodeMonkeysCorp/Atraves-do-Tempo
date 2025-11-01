# PuzzleArea
extends Area2D

var botoes_puzzle: Node = null
var camera: Node = null
var player_node: Node = null

@export var zoom_normal: Vector2 = Vector2(1.2, 1.2)
@export var zoom_olhar: Vector2 = Vector2(0.75, 0.75)
@onready var interagir_puzzleTxt = $"../../player/InteragirPuzzle"

@export var limites_puzzle := {
	"left": 2820,
	"right": 9100,
	"top": 0,
	"bottom": 1080
}

var player_na_area: bool = false
var puzzle_ativo: bool = false
var limites_originais: Dictionary = {}

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	botoes_puzzle = get_tree().get_current_scene().find_child("Variaveis", true, false)
	if botoes_puzzle == null and get_parent().has_node("Variaveis"):
		botoes_puzzle = get_parent().get_node("Variaveis")
	if botoes_puzzle:
		if botoes_puzzle.has_method("hide"):
			botoes_puzzle.hide()
	player_node = get_tree().get_current_scene().find_child("player", true, false)
	if player_node == null and get_parent().has_node("player"):
		player_node = get_parent().get_node("player")
	if player_node:
		camera = player_node.find_child("Camera2D", true, false)
	else:
		camera = get_tree().get_current_scene().find_child("Camera2D", true, false)
	if camera:
		limites_originais = {
			"left": camera.limit_left,
			"right": camera.limit_right,
			"top": camera.limit_top,
			"bottom": camera.limit_bottom
		}

func _on_body_entered(body: Node) -> void:
	if not (body.is_in_group("player") or body.name == "player"):
		return
	player_na_area = true
	if body.has_method("interagirPuzzleShow"):
		body.interagirPuzzleShow()

func _on_body_exited(body: Node) -> void:
	if not (body.is_in_group("player") or body.name == "player"):
		return
	player_na_area = false
	if body.has_method("interagirPuzzleHide"):
		body.interagirPuzzleHide()
	if puzzle_ativo:
		desativar_puzzle()

func _process(_delta: float) -> void:
	if player_na_area and not puzzle_ativo and Input.is_action_just_pressed("interagir"):
		ativar_puzzle()

func ativar_puzzle() -> void:
	puzzle_ativo = true
	interagir_puzzleTxt.hide()
	if botoes_puzzle:
		if botoes_puzzle.has_method("show"):
			botoes_puzzle.show()
	if camera and camera.has_method("definir_zoom_puzzle"):
		camera.definir_zoom_puzzle(true)
		camera.set_limites(limites_puzzle)

func desativar_puzzle() -> void:
	puzzle_ativo = false
	interagir_puzzleTxt.show()
	if botoes_puzzle:
		if botoes_puzzle.has_method("hide"):
			botoes_puzzle.hide()
	if camera and camera.has_method("definir_zoom_puzzle"):
		camera.definir_zoom_puzzle(false)
		camera.set_nova_posicao(camera.global_position, false)
		camera.set_limites(limites_originais)
