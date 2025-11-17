extends Node2D

@onready var tentativasEgito = $Tentativas/TentativasEgito
@onready var tentativasGrecia = $Tentativas/TentativasGrecia
@onready var tentativasIdadeMedia = $Tentativas/TentativasIdadeMedia

@onready var tempoEgito = $Tempo/TempoEgito
@onready var tempoGrecia = $Tempo/TempoGrecia
@onready var tempoIdadeMedia = $Tempo/TempoIdadeMedia

@onready var dicasEgito = $Dicas/DicasEgito
@onready var dicasGrecia = $Dicas/DicasGrecia
@onready var dicasIdadeMedia = $Dicas/DicasidadeMedia

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tentativasEgito.add_theme_color_override("font_color", Color.YELLOW_GREEN)
	tentativasGrecia.add_theme_color_override("font_color", Color.YELLOW)
	tentativasIdadeMedia.add_theme_color_override("font_color", Color.BLUE)
	
	tempoEgito.add_theme_color_override("font_color", Color.YELLOW_GREEN)
	tempoGrecia.add_theme_color_override("font_color", Color.YELLOW)
	tempoIdadeMedia.add_theme_color_override("font_color", Color.BLUE)
	
	dicasEgito.add_theme_color_override("font_color", Color.YELLOW_GREEN)
	dicasGrecia.add_theme_color_override("font_color", Color.YELLOW)
	dicasIdadeMedia.add_theme_color_override("font_color", Color.BLUE)
	
	tentativasEgito.text = str(GameManager.tentativasEgito)
	tentativasGrecia.text = str(GameManager.tentativasGrecia)
	tentativasIdadeMedia.text = str(GameManager.tentativasIdadeMedia)
	
	tempoEgito.text = formatar_tempo(GameManager.tempos.get("PuzzleEgito", 0))
	tempoGrecia.text = formatar_tempo(GameManager.tempos.get("PuzzleGrecia", 0))
	tempoIdadeMedia.text = formatar_tempo(GameManager.tempos.get("PuzzleIdadeMedia", 0))
	
	dicasEgito.text = str(GameManager.dicasEgito)
	dicasGrecia.text = str(GameManager.dicasGrecia)
	dicasIdadeMedia.text = str(GameManager.dicasIdadeMedia)

func formatar_tempo(segundos: float) -> String:
	var minutos = int(segundos) / 60
	var seg = int(segundos) % 60
	return str(minutos) + "m " + str(seg) + "s"

func _on_btn_voltar_pressed() -> void:
	print("Função do botão: Sair da Página de Dados da Gameplay")
	GameManager.goto("MainMenu")
