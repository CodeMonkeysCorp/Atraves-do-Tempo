extends Area2D #BY Matheus Busemayer

var player_na_area: bool = false
var puzzle_ativo: bool = false
var puzzle_scene = preload("res://scenes/PuzzleEgito.tscn")
var puzzle_instance: Control
@onready var player = $"../../player"
@onready var npc = $"../../npc"
@onready var sinal_puzzle = $SinalPuzzle

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "player":
		player_na_area = true
		#if body.has_method("interagirPuzzleShow"):
			#body.interagirPuzzleShow()

func _on_body_exited(body):
	if body.name == "player":
		player_na_area = false
		#if body.has_method("interagirPuzzleHide"):
			#body.interagirPuzzleHide()

func _process(delta):
	if player_na_area and not puzzle_ativo and Input.is_action_just_pressed("interagir"):
		player.lock_movement()
		player.hide()
		npc.hide()
		puzzle_ativo = true
		puzzle_instance = puzzle_scene.instantiate()
		add_child(puzzle_instance)
	elif puzzle_ativo and Input.is_action_just_pressed("cancelar"):
		puzzle_ativo = false
		npc.show()
		player.unlock_movement()
		player.show()
		if puzzle_instance:
			puzzle_instance.queue_free()
