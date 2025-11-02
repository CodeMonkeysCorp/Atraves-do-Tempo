extends Button #BY Matheus Busemayer

func _on_pressed() -> void:
	GameManager.goto("MainMenu")
	OS.shell_open("https://github.com/CodeMonkeysCorp/Atraves-do-Tempo/tree/Dialogos-personagens-problemas-menores")
