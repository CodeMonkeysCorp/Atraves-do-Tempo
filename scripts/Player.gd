extends CharacterBody2D #BY Matheus Busemayer

@export var speed: float = 500.0
@onready var interagir_label = $Interagir
@onready var interagir_puzzle_label = $InteragirPuzzle
@onready var anim = $AnimatedSprite2D
# travar movimento para dialogo 
var can_move: bool = true

func _ready() -> void:
	interagir_puzzle_label.hide()
	
func interagirShow():
	if interagir_label:
		interagir_label.show()

func interagirHide():
	if interagir_label:
		interagir_label.hide()

func interagirPuzzleShow():
	if interagir_puzzle_label:
		interagir_puzzle_label.show()

func interagirPuzzleHide():
	if interagir_puzzle_label:
		interagir_puzzle_label.hide()

func lock_movement():
	can_move = false
	anim.play("idle")

func unlock_movement():
	can_move = true

func _physics_process(delta):
	if not can_move:
		return
	var direction := 0.0
	# entrada do teclado
	if Input.is_action_pressed("andar_esquerda"):
		direction -= 1
	if Input.is_action_pressed("andar_direita"):
		direction += 1

	# movimento horizontal
	velocity.x = direction * speed
	# mantém gravidade ou zera o Y se não for usar pulo
	# velocity.y = 0   # <- só use se NÃO quiser gravidade

	move_and_slide()

	# pega o AnimatedSprite2D
	var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

	# troca de animações
	if direction != 0:
		anim_sprite.play("run")              # toca animação de corrida
		anim_sprite.flip_h = direction < 0   # vira o sprite se for esquerda
	else:
		anim_sprite.play("idle")             # toca animação parada
