extends Node2D
 
@onready var sprite = $"../Dialogo/CaixaDialogo"
@onready var label_txt = $"../Dialogo/CaixaDialogo/Label"
@onready var sinal = $SinalInteragir

var fala: int = 0
var dialogo_ativo: int = 0
# 0 = INATIVO, 1 = ATIVO, 2 = REPETIR ÚLTIMA FRASE
 
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
		fala = 3  # Trava na última fala
		
		show_dialog()
 
func proximo_dialogo():
	if Input.is_action_just_pressed("interagir"):
		fala += 1
		show_dialog()
 
func show_dialog():
	match fala:
		0:
			label_txt.text = "Hola HermanoHola HermanoHola Hermano..."
		1:
			label_txt.text = "segundosegundosegundosegundo"
		2:
			label_txt.text = "terceiroterceiroterceiroterceiro"
			sinal.hide()
		3:
			# Resumo da quest/puzzle nosso
			label_txt.text = "Se de fato conseguir resolver esse problema pra mim eu lhe darei esse Fragmento de Relógio"
			dialogo_ativo = 2  # Trava aqui e some se passar dialogo
			if Input.is_action_just_pressed("interagir"):
				sprite.hide()
				label_txt.hide()
		_:
			fala = 3
			dialogo_ativo = 2
