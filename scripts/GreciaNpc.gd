extends Node2D
 
@onready var sprite = $"../Dialogo/CaixaDialogo"
@onready var label_txt = $"../Dialogo/CaixaDialogo/Label"
@onready var sinal = $SinalInteragir

var fala: int = 0
var dialogo_ativo: int = 0
 
func _ready():
	$Area2D.body_entered.connect(_on_area_body_entered)
	$Area2D.body_exited.connect(_on_area_body_exited)
	sinal.show()
	sprite.hide()
	label_txt.hide()
 
func _on_area_body_entered(body):
	if body.name == "player":
		# Só ativa diálogo se ainda não finalizou (dialogo_ativo != 2)
		if dialogo_ativo != 2:
			dialogo_ativo = 1
			sinal.hide()
			sprite.show()
			label_txt.show()
			show_dialog()
		elif dialogo_ativo == 2:
			# Se já finalizou, mostra apenas a última fala
			sprite.show()
			label_txt.show()
			fala = 3
			show_dialog()
 
func _on_area_body_exited(body):
	if body.name == "player":
		if dialogo_ativo != 2:
			sinal.show()
		dialogo_ativo = 0
		sprite.hide()
		label_txt.hide()
		
 
func _process(delta):
	if dialogo_ativo == 1:
		proximo_dialogo()
	elif dialogo_ativo == 2:
		proximo_dialogo()
	elif dialogo_ativo == 3:
		proximo_dialogo()
	elif dialogo_ativo == 4:
		proximo_dialogo()
	elif dialogo_ativo == 5:
		proximo_dialogo()
	elif dialogo_ativo == 6:
		fala = 7  # Trava na última fala
		
		show_dialog()
 
func proximo_dialogo():
	if Input.is_action_just_pressed("interagir"):
		fala += 1
		show_dialog()
 
func show_dialog():
	match fala:
		0:
			label_txt.text = "Ah, olá, jovem. Meu nome é Epícuro."
		1:
			label_txt.text = 'Eu moro aqui perto e sempre venho matar
			tempo observando estas belas estruturas.'
		2:
			label_txt.text = 'Estava aqui quebrando a cabeça com uma coisa...
			Veja aquele pilar ali. Eu sei que ele tem 3 metros de altura, eu medi uma vez.'
		3:
			label_txt.text = 'Agora, olhe a sombra dele no chão. É tão comprida!'
			
		4:
			label_txt.text = 'Eu medi e da base do pilar até a ponta da sombra dá uns 4 metros.'
			
		5:
			label_txt.text = 'Mas e a linha que vai da ponta da sombra para a ponta do pilar?'
			
		6:
			label_txt.text = 'Eu olho e vejo que forma um triângulo,
			mas não tenho ideia de como calcular essa terceira linha.'
			sinal.hide()
			
		7:
			# Resumo da quest/puzzle nosso
			label_txt.text = 'Você... por acaso, entende desses cálculos?
			Poderia me ajudar a descobrir?'
			dialogo_ativo = 2  # Trava aqui e some se passar dialogo
			if Input.is_action_just_pressed("interagir"):
				sprite.hide()
				label_txt.hide()
		_:
			fala = 7
			dialogo_ativo = 6
