extends Node2D #BY Matheus Busemayer

@onready var caixaDialogo = $"../Dialogo/LigaDesligaDialogos/Dialogo"
@onready var label_txt = $"../Dialogo/LigaDesligaDialogos/Dialogo/Label"
@onready var QuemFala = $"../Dialogo/LigaDesligaDialogos/Dialogo/QuemFala"
@onready var player = get_parent().get_node("player")
#@onready var interagir_txt = $"../player/Interagir"
@onready var interagir_puzzle = $"../Sprite2D/AreaPuzzle"
@onready var sinalInteragir = $SinalInteragir
@onready var sinal_puzzle = $"../Sprite2D/AreaPuzzle/Pilar/SinalPuzzle"

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
		fala = 13
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
			QuemFala.text = "Epicuro"
			label_txt.text = "Ah, um jovem viajante! Vejo em teus olhos a curiosidade dos sábios."

		1:
			QuemFala.text = "Epicuro"
			label_txt.text = "Dize-me, pequeno, observas este pilar diante de nós?"

		2:
			QuemFala.text = "  Luca"
			label_txt.text = "Sim! Ele é bem alto, e tem uma sombra comprida!"

		3:
			QuemFala.text = "Epicuro"
			label_txt.text = "Quando o Sol brilha, o pilar projeta essa sombra sobre o chão."

		4:
			QuemFala.text = "Epicuro"
			label_txt.text = "Sei o tamanho do pilar e o comprimento da sombra..."

		5:
			QuemFala.text = "Epicuro"
			label_txt.text = "...mas falta descobrir a distância entre o topo do pilar e a ponta da sombra."

		6:
			QuemFala.text = "  Luca"
			label_txt.text = "Ah, então é tipo um triângulo! O pilar, a sombra e essa distância!"

		7:
			QuemFala.text = "Epicuro"
			label_txt.text = "Exato, pequeno filósofo. Essa distância é a hipotenusa."

		8:
			QuemFala.text = "Epicuro"
			label_txt.text = "Tua tarefa é calculá-la, usando o Teorema de Pitágoras: h² = pilar² + sombra²."

		9:
			QuemFala.text = "  Luca"
			label_txt.text = "Entendi! Então é só somar os quadrados e tirar a raiz. Deixa comigo!"

		10:
			QuemFala.text = "Epicuro"
			label_txt.text = "Muito bem! Retorna a mim com o valor correto, e te revelarei um segredo da luz e da razão."
		11:
			QuemFala.text = "Epicuro"
			label_txt.text = "Agora concentra-te, jovem viajante. Que comece teu desafio!"

		12:
			dialogo_finalizado = true
			interagir_puzzle.monitoring = true
			sinal_puzzle.show()
			_encerrar_dialogo()
		13:
			QuemFala.text = "Epicuro"
			label_txt.text = "Ainda não descobriste a resposta, jovem viajante?"

		14:
			QuemFala.text = "Epicuro"
			label_txt.text = "Observa bem o pilar e sua sombra... o triângulo guarda o segredo da medida."

		15:
			QuemFala.text = "Epicuro"
			label_txt.text = "Volta quando tiveres a hipotenusa. Estou ansioso por tua descoberta!"
		_:
			_encerrar_dialogo()
