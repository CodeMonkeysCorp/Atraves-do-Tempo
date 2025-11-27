extends Node2D #BY Matheus Busemayer

@onready var caixaDialogo = $"../Dialogo/LigaDesligaDialogos/Dialogo"
@onready var label_txt = $"../Dialogo/LigaDesligaDialogos/Dialogo/Label"
@onready var QuemFala = $"../Dialogo/LigaDesligaDialogos/Dialogo/QuemFala"
@onready var player = get_parent().get_node("player")
#@onready var interagir_txt = $"../player/Interagir"
@onready var interagir_puzzle = $"../Sprite2D/AreaPuzzle"
@onready var sinalInteragir = $SinalInteragir
@onready var sinal_puzzle = $"../Sprite2D/AreaPuzzle/SinalPuzzle"

var fala: int = 0
var dialogo_ativo: bool = false
var player_na_area: bool = false
var dialogo_finalizado: bool = false

func _ready():
	$Area2D.body_entered.connect(_on_area_body_entered)
	$Area2D.body_exited.connect(_on_area_body_exited)
	sinalInteragir.show()
	#interagir_txt.hide()
	caixaDialogo.hide()
	label_txt.hide()
	interagir_puzzle.monitoring = false
	sinal_puzzle.hide()
	
func _on_area_body_entered(body):
	if body.name == "player":
		player_na_area = true
		#interagir_txt.show()
		#if body.has_method("interagirShow"):
			#body.interagirShow()

func _on_area_body_exited(body):
	if body.name == "player":
		player_na_area = false
		#interagir_txt.hide()
		#if body.has_method("interagirHide"):
		#	body.interagirHide()
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
	#interagir_txt.hide()
	player.hide()
	hide() # esconde o NPC
	#if player.has_method("interagirHide"):
		#player.interagirHide()
	caixaDialogo.show()
	label_txt.show()

	if player and player.has_method("lock_movement"):
		player.lock_movement()

	if dialogo_finalizado:
		fala = 9
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
			QuemFala.text = "Inácio"
			label_txt.text = "Ei, você aí! Sim, você mesmo! Parece um viajante esperto, venha cá um instante!"
		1:
			QuemFala.text = "  Luca"
			label_txt.text = "Oi! Eu? Claro! No que posso ajudar?"
		2:
			QuemFala.text = "Inácio"
			label_txt.text = "Tenho um pequeno problema de contas... e todos sabem que viajantes são bons com números!"
		3:
			QuemFala.text = "  Luca"
			label_txt.text = "Depende... é sobre o quê exatamente?"
		4:
			QuemFala.text = "Inácio"
			label_txt.text = "Naquela mesa ali, há um cálculo com frações que está me tirando o sono!"
		5:
			QuemFala.text = "Inácio"
			label_txt.text = "Meus empregados estão ocupados demais — então, que tal me dar uma mão, hein?"
		6:
			QuemFala.text = "  Luca"
			label_txt.text = "Frações, é? Acho que consigo resolver isso pra você!"
		7:
			QuemFala.text = "Inácio"
			label_txt.text = "Excelente! Resolva o desafio e eu prometo que serei... digamos, generoso na recompensa!"
		8:
			dialogo_finalizado = true
			interagir_puzzle.monitoring = true
			sinal_puzzle.show()
			_encerrar_dialogo()
		9:
			QuemFala.text = "Inácio"
			label_txt.text = "Ora, ainda não resolveu aquele probleminha de frações?"
		10:
			QuemFala.text = "  Luca"
			label_txt.text = "Ainda não... mas tô quase lá!"
		11:
			QuemFala.text = "Inácio"
			label_txt.text = "Vamos, meu jovem! O dinheiro não se faz sozinho!"
		_:
			_encerrar_dialogo()
