extends CanvasLayer #BY Matheus Busemayer
@onready var fade = $ColorRect

func mostrar():
	fade.modulate.a = 0.5

func esconder():
	fade.modulate.a = 0.0
