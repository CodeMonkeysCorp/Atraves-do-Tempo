extends Node2D

@onready var catapulta = $Catapulta
@onready var valorA = $Variáveis/A
@onready var valorB = $Variáveis/B
@onready var alvo = $"Marcação"
var offsetCatapulta = Vector2(-130,-40)

func _draw():
	var points = []
	var step = 0.25
	var scale = 60
	
	var a = valorA.text.strip_edges()
	var b = valorB.text.strip_edges()
	if a == '' or b == '': return
	a = a.to_float()
	b = b.to_float()
	
	for i in range(int(1000.0 / step)):
		var x = i * step
		
		var y = -(a*pow(x,2))+(b*(x))
		var ponto = catapulta.position+offsetCatapulta+Vector2(x*scale,-y*scale)
		
		var xDiff = abs(alvo.position.x-ponto.x)
		var yDiff = abs(alvo.position.y-ponto.y)
		if yDiff <= 10 and xDiff <= 10:
			break
		points.append(ponto)
	
	draw_polyline(points, Color(0.772, 0.0, 0.0, 1.0), 5.0)

func _process(_delta):
	queue_redraw()
