extends Button #BY Matheus Busemayer

func _on_pressed() -> void:
	GameManager.goto("MainMenu")
	OS.shell_open("https://forms.office.com/pages/responsepage.aspx?id=RO2KG9CnnECXlrJkWUmGoNkQeX18GNlBiWVsfxP8Hz5UQUNHVUtXVUNFVUowVEw5MUtPSEwwSFNWQy4u&route=shorturl")
