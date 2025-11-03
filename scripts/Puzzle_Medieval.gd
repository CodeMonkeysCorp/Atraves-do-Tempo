extends Node2D #BY Matheus Busemayer

@onready var catapulta = $Catapulta
@onready var valorA = $Variaveis/A
@onready var valorB = $Variaveis/B
@onready var botao_confirmar = $Variaveis/BotaoConfirmar

var offsetCatapulta = Vector2(-130, -40)
var confirmar_press = false
var pontos_trajetoria: Array = []
var pode_confirmar = true
var impacto_visual: Vector2 = Vector2.ZERO

# 🔵 --- DEFINIÇÃO DA ÁREA DE ACERTO (mude aqui) ---
# posição do centro do alvo
var alvo_centro = Vector2(1055, 390)
# tamanho do raio (quanto maior, mais fácil acertar)
var alvo_raio = 35.0
# 🔵 --- FIM DAS CONFIGURAÇÕES DO ALVO ---

func _ready():
	botao_confirmar.pressed.connect(_on_botao_confirmar_pressed)
	gerar_trajetoria()

func gerar_trajetoria():
	pontos_trajetoria.clear()

	var step = 0.8
	var scale = 60
	var base_spacing = 10.0
	var base_radius = 6.0
	var radius_decay = 0.15

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


# 🔵 Verifica se um ponto está dentro da área de acerto definida por coordenadas
func ponto_dentro_area(ponto: Vector2) -> bool:
	return ponto.distance_to(alvo_centro) <= alvo_raio


# Verifica se a linha entre dois pontos cruza a área
func linha_perto_da_area(p1: Vector2, p2: Vector2, passos := 20) -> bool:
	for i in range(passos + 1):
		var t = i / float(passos)
		var ponto = p1.lerp(p2, t)
		if ponto_dentro_area(ponto):
			impacto_visual = ponto
			return true
	return false


# Desenha a trajetória e o alvo
func _draw():
	# desenha pontos da trajetória
	for p in pontos_trajetoria:
		draw_circle(p["pos"], p["radius"], Color(0.772, 0.0, 0.0, 1.0))

	# desenha o alvo (círculo azul translúcido)
	draw_circle(alvo_centro, alvo_raio, Color(0, 0, 0, 0.0))

	# desenha o impacto se houver acerto
	if impacto_visual != Vector2.ZERO:
		draw_circle(impacto_visual, 8, Color(0, 1, 0))

	# quando o botão é pressionado, testa a trajetória
	if confirmar_press and pontos_trajetoria.size() > 0:
		var todos_pontos = []
		for p in pontos_trajetoria:
			todos_pontos.append(p["pos"])

		var acertou = false
		impacto_visual = Vector2.ZERO

		for i in range(todos_pontos.size() - 1):
			if linha_perto_da_area(todos_pontos[i], todos_pontos[i + 1]):
				acertou = true
				break

		if acertou:
			await get_tree().create_timer(1.5).timeout
			Musica.parar_todas()
			GameManager.goto("Creditos")
		else:
			print("Errou, tente ajustar os valores!")

		confirmar_press = false


# Adiciona delay de 1.5s entre confirmações
func _on_botao_confirmar_pressed():
	if not pode_confirmar:
		return

	pode_confirmar = false
	confirmar_press = true
	gerar_trajetoria()
	queue_redraw()

	await get_tree().create_timer(1.5).timeout
	pode_confirmar = true
