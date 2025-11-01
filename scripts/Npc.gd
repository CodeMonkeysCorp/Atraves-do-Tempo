extends Node2D #BY Matheus Busemayer

@onready var caixaDialogo = $"../Dialogo/LigaDesligaDialogos/Dialogo"
@onready var label_txt = $"../Dialogo/LigaDesligaDialogos/Dialogo/Label"
@onready var player = get_parent().get_node("player")
@onready var interagir_txt = $"../player/Interagir"
@onready var interagir_puzzle = $"../Sprite2D/AreaPuzzle"
@onready var sinalInteragir = $SinalInteragir

var fala: int = 0
var dialogo_ativo: bool = false
var player_na_area: bool = false
var dialogo_finalizado: bool = false

func _ready():
	$Area2D.body_entered.connect(_on_area_body_entered)
	$Area2D.body_exited.connect(_on_area_body_exited)
	sinalInteragir.show()
	interagir_txt.hide()
	caixaDialogo.hide()
	label_txt.hide()
	interagir_puzzle.monitoring = false
	
func _on_area_body_entered(body):
	if body.name == "player":
		player_na_area = true
		interagir_txt.show()
		if body.has_method("interagirShow"):
			body.interagirShow()

func _on_area_body_exited(body):
	if body.name == "player":
		player_na_area = false
		interagir_txt.hide()
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
	sinalInteragir.hide()
	interagir_txt.hide()
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
			label_txt.text = "Ei, voce! Tu mesmo, voce é um mercador viajante né. Ótimo venha aqui e me ajude."
		1:
			label_txt.text = "Voce é bom frações né, todo mercador é então me ajude com o problema naquela mesa"
		2:
			label_txt.text = "Meus empregados estão ocupados demais pra lidar com isso."
			dialogo_finalizado = true
			interagir_puzzle.monitoring = true
			_encerrar_dialogo()
		3:
			label_txt.text = "E sobre recompensa apenas digamos que sou generoso..."
		_:
			_encerrar_dialogo()
