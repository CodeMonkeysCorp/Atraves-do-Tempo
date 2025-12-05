extends VideoStreamPlayer

var fluxo_de_jogo = {
	"Intro": "FaseEgito",
	"FaseEgito": "FaseGrecia",
	"FaseGrecia": "FaseIdadeMedia",
	"FaseIdadeMedia": "CenaFinal"
} # define qual é a próxima scene baseada na anterior

func _ready():
	if not finished.is_connected(_on_finished):
		finished.connect(_on_finished)
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN  # esconde o mouse durante a transição
	play()  # garante que o vídeo toque

func _on_finished():
	_direcionar_jogador()

func _direcionar_jogador():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE  # mostra o mouse de novo
	
	var origem = GameManager.ultima_fase_concluida
	
	if fluxo_de_jogo.has(origem):
		var destino = fluxo_de_jogo[origem]
		GameManager.goto(destino)
	else:
		print("Origem desconhecida: ", origem, ". Voltando ao Menu.")
		GameManager.goto("MainMenu")  # se algo der errado ou a origem não estiver mapeada, volta pro menu

func _input(event):
	if event is InputEventKey and event.pressed:
		stop()  # para o vídeo
		_direcionar_jogador()  # chama a troca de cena imediatamente
