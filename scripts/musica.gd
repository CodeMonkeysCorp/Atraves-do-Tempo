extends Node2D

func tocar(nome: String):
	var musica = MusicaCena.get_node_or_null(nome)
	if musica:
		parar_todas()
		musica.playing = true
	else:
		push_warning("Música '%s' não encontrada em Musica.tscn" % nome)

func parar_todas():
	MusicaCena.get_node_or_null('Egito').playing = false
	MusicaCena.get_node_or_null('Grecia').playing = false
	MusicaCena.get_node_or_null('Medieval').playing = false
