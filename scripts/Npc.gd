extends Node2D #BY Matheus Busemayer

@onready var caixaDialogo = $"../Dialogo/LigaDesligaDialogos/Dialogo"
@onready var label_txt = $"../Dialogo/LigaDesligaDialogos/Dialogo/Label"
@onready var player = get_parent().get_node("player")
@onready var sinal = $"../player/Interagir"
@onready var interagir_puzzle = $"../Sprite2D/AreaPuzzle"

var fala: int = 0
var dialogo_ativo: bool = false
var player_na_area: bool = false
var dialogo_finalizado: bool = false

func _ready():
	$Area2D.body_entered.connect(_on_area_body_entered)
	$Area2D.body_exited.connect(_on_area_body_exited)

	sinal.hide()
	caixaDialogo.hide()
	label_txt.hide()
	interagir_puzzle.monitoring = false
	
func _on_area_body_entered(body):
	if body.name == "player":
		player_na_area = true
		sinal.show()
		if body.has_method("interagirShow"):
			body.interagirShow()

func _on_area_body_exited(body):
	if body.name == "player":
		player_na_area = false
		sinal.hide()
		if body.has_method("interagirHide"):
			body.interagirHide()
		if dialogo_ativo:
			_encerrar_dialogo()

func _process(delta):
	if player_na_area and not dialogo_ativo and Input.is_action_just_pressed("interagir"):
		_iniciar_dialogo()
	elif dialogo_ativo and Input.is_action_just_pressed("interagir"):
		proximo_dialogo()

func _iniciar_dialogo():
	dialogo_ativo = true
	sinal.hide()
	player.hide()
	hide() # esconde o NPC
	if player.has_method("interagirHide"):
		player.interagirHide()
	caixaDialogo.show()
	label_txt.show()

	if player and player.has_method("lock_movement"):
		player.lock_movement()

	if dialogo_finalizado:
		fala = 3
	else:
		fala = 0

	show_dialog()

func _encerrar_dialogo():
	player.show()
	show() # mostra o NPC
	dialogo_ativo = false
	caixaDialogo.hide()
	label_txt.hide()

	if player and player.has_method("unlock_movement"):
		player.unlock_movement()

func proximo_dialogo():
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
			dialogo_finalizado = true
			interagir_puzzle.monitoring = true
			_encerrar_dialogo()
		3:
			label_txt.text = "Se de fato conseguir resolver esse problema pra mim eu lhe darei esse Fragmento de Relógio"
		_:
			_encerrar_dialogo()
