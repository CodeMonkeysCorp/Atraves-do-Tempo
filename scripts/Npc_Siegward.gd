extends Node2D #BY Matheus Busemayer

@onready var filtroEscuro = $"../Dialogo/LigaDesligaDialogos/Dialogo/FiltroEscuro"
@onready var caixaDialogo = $"../Dialogo/LigaDesligaDialogos/Dialogo"
@onready var QuemFala = $"../Dialogo/LigaDesligaDialogos/Dialogo/QuemFala"
@onready var label_txt = $"../Dialogo/LigaDesligaDialogos/Dialogo/Label"
@onready var player = get_parent().get_node_or_null("player")
@onready var interagir_txt = $"../player/Interagir"
@onready var interagir_puzzle = get_node("../PuzzleMedieval/Sprite2D/AreaPuzzle2") as Area2D
@onready var sinalInteragir =  $SinalInteragir
@onready var barreira_direita = $"../LimiteMundo/CollisionShape2DRight"
@onready var setinha = $"../Setinha"

var fala: int = 0
var dialogo_ativo: bool = false
var player_na_area: bool = false
var dialogo_finalizado: bool = false
var cena_atual = 1

func _ready():
	$Area2D.body_entered.connect(_on_area_body_entered)
	$Area2D.body_exited.connect(_on_area_body_exited)
	sinalInteragir.show()
	interagir_txt.hide()
	caixaDialogo.hide()
	label_txt.hide()
	filtroEscuro.hide()
	
	# Garantir que interagir_puzzle é um Area2D antes de alterar monitoring
	if interagir_puzzle:
		interagir_puzzle.monitoring = false
	else:
		print("Erro: interagir_puzzle não foi encontrado ou não é um Area2D")

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
			#body.interagirHide()
		if dialogo_ativo:
			_encerrar_dialogo()

func _process(delta):
	if player_na_area and not dialogo_ativo and Input.is_action_just_pressed("interagir"):
		_iniciar_dialogo()
	elif dialogo_ativo and Input.is_action_just_pressed("interagir"):
		proximo_dialogo()

func _iniciar_dialogo():
	dialogo_ativo = true
	#interagir_txt.hide()
	sinalInteragir.hide()
	player.hide()
	hide()
	#if player and player.has_method("interagirHide"):
		#player.interagirHide()
	filtroEscuro.show()
	caixaDialogo.show()
	label_txt.show()
	if player and player.has_method("lock_movement"):
		player.lock_movement()
	if dialogo_finalizado:
		fala = 7
	else:
		fala = 0
	show_dialog()

func _encerrar_dialogo():
	player.show()
	#interagir_txt.show()
	show()
	filtroEscuro.hide()
	caixaDialogo.hide()
	label_txt.hide()
	dialogo_ativo = false
	if player and player.has_method("unlock_movement"):
		player.unlock_movement()

func proximo_dialogo():
	fala += 1
	show_dialog()

func show_dialog():
	match fala:
		0:
			QuemFala.text = "Siegward"
			label_txt.text = "Ei, você, meu jovem escudeiro! Venha cá."
		1:
			QuemFala.text = "Siegward"
			label_txt.text = "Precisamos de gente para manter a catapulta em funcionamento."
		2:
			QuemFala.text = "  Luca"
			label_txt.text = "Eu posso ajudar! Já usei coisas parecidas antes."
		3:
			QuemFala.text = "Siegward"
			label_txt.text = "Se o operador da catapulta cair, você deve assumir o lugar dele. Basta ajustar a distância e a força corretamente."
		4:
			QuemFala.text = "  Luca"
			label_txt.text = "Entendi! É só calcular e mirar, certo?"
		5:
			QuemFala.text = "Siegward"
			label_txt.text = "Exato! Cada erro prolonga o cerco, e não podemos desperdiçar mais meses de esforço."
			dialogo_finalizado = true
			if interagir_puzzle:
				interagir_puzzle.monitoring = true
			barreira_direita.position.y = 750.0
			setinha.show()
		6:
			_encerrar_dialogo()
		7:
			QuemFala.text = "Siegward"
			label_txt.text = "Vá! Ajuste bem a força e a distância. O sucesso do ataque depende de você."
		8:
			QuemFala.text = "  Luca"
			label_txt.text = "Pode deixar, Siegward! Vou fazer o meu melhor!"
		_:
			_encerrar_dialogo()
