extends CharacterBody2D

@export var speed: float = 500.0

func _physics_process(delta):
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
