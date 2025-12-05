extends Node2D #BY Matheus Busemayer

@onready var catapulta = $Catapulta
@onready var valorA = $Variaveis/A
@onready var valorB = $Variaveis/B
@onready var botao_confirmar = $Variaveis/BotaoConfirmar
@onready var feedback = $Variaveis/Errou
@onready var label_dica = $Variaveis/Dica

var offsetCatapulta = Vector2(-130, -40)
var confirmar_press = false
var pontos_trajetoria: Array = []
var pode_confirmar = true
var impacto_visual: Vector2 = Vector2.ZERO

var alvo_centro = Vector2(1055, 390)
var alvo_raio = 35.0
var tempo_inicio: float

var dica_1 = false
var dica_2 = false

func _ready():
	botao_confirmar.pressed.connect(_on_botao_confirmar_pressed)
	gerar_trajetoria()

func gerar_trajetoria():
	pontos_trajetoria.clear()

	var step = 0.1        # <<< ALTERADO AQUI
	var scale = 60
	var base_spacing = 4.0
	var base_radius = 6.0
	var radius_decay = 0.05

	var a_text = valorA.text.strip_edges()
	var b_text = valorB.text.strip_edges()
	if a_text == '' or b_text == '':
		return

	var a = a_text.to_float()
	var b = b_text.to_float()

	var last_dot_pos = Vector2.ZERO
	var first_dot = true
	var current_radius = base_radius

	for i in range(int(1000.0 / step)):
		var x = i * step
		var y = -(a * pow(x, 2)) + (b * x)
		var ponto = catapulta.position + offsetCatapulta + Vector2(x * scale, -y * scale)

		if first_dot or ponto.distance_to(last_dot_pos) >= base_spacing:
			pontos_trajetoria.append({
				"pos": ponto,
				"radius": current_radius
			})
			last_dot_pos = ponto
			first_dot = false
			current_radius = max(1.0, current_radius - radius_decay)

	queue_redraw()


func ponto_dentro_area(ponto: Vector2) -> bool:
	return ponto.distance_to(alvo_centro) <= alvo_raio


func linha_perto_da_area(p1: Vector2, p2: Vector2, passos := 20) -> bool:
	for i in range(passos + 1):
		var t = i / float(passos)
		var ponto = p1.lerp(p2, t)
		if ponto_dentro_area(ponto):
			impacto_visual = ponto
			return true
	return false


func _draw():
	# --- DESENHAR A LINHA DA TRAJETÓRIA ---
	if pontos_trajetoria.size() >= 2:
		for i in range(pontos_trajetoria.size() - 1):
			var p1 = pontos_trajetoria[i]["pos"]
			var p2 = pontos_trajetoria[i + 1]["pos"]
			draw_line(p1, p2, Color(0.8, 0, 0), 3.0)

	# --- DESENHA ALVO ---
	draw_circle(alvo_centro, alvo_raio, Color(0, 0, 0, 0.0))

	# --- DESENHA LOCAL DO IMPACTO ---
	if impacto_visual != Vector2.ZERO:
		draw_circle(impacto_visual, 8, Color(0, 1, 0))


	# --- VERIFICAÇÃO DE ACERTO QUANDO APERTA O BOTÃO ---
	if confirmar_press and pontos_trajetoria.size() > 0:
		var todos_pontos = []
		for p in pontos_trajetoria:
			todos_pontos.append(p["pos"])

		var acertou = false
		impacto_visual = Vector2.ZERO

		for i in range(todos_pontos.size() - 1):
			if linha_perto_da_area(todos_pontos[i], todos_pontos[i + 1]):
				acertou = true
				feedback.text = "Acertou"
				feedback.show()
				break

		if acertou:
			await get_tree().create_timer(1.5).timeout
			Musica.parar_todas()
			var tempo_total = (Time.get_ticks_msec() - tempo_inicio) / 1000.0
			GameManager.registrar_tempo("PuzzleIdadeMedia", tempo_total)
			GameManager.concluir_fase("FaseIdadeMedia")
			GameManager.contar_dicas_IdadeMedia(dica_1, dica_2)
			GameManager.tentativasIdadeMedia += 1
		else:
			print("Errou, tente ajustar os valores!")
			feedback.show()
			await get_tree().create_timer(1.0).timeout
			feedback.hide()
			GameManager.tentativasIdadeMedia += 1
			_mostrar_dica()
			
		confirmar_press = false


func _mostrar_dica():
	if GameManager.tentativasIdadeMedia < 5 and GameManager.tentativasIdadeMedia >= 2:
		label_dica.show()
		dica_1 = true
	if GameManager.tentativasIdadeMedia >= 5:
		label_dica.text = "Dica 2: Use o Mínimo Multiplo Comum das bases nas frações"
		dica_2 = true


func _on_botao_confirmar_pressed():
	if not pode_confirmar:
		return
	pode_confirmar = false
	confirmar_press = true
	gerar_trajetoria()
	queue_redraw()

	await get_tree().create_timer(1.5).timeout
	pode_confirmar = true
