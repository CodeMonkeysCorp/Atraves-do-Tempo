extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var click_pos: Vector2 = event.position  # posição global do clique

		for btn in $MenuBox.get_children():
			if btn is TextureButton:
				# Converter posição global para local do botão
				var local_pos: Vector2 = btn.get_global_transform().affine_inverse() * click_pos
				var size: Vector2 = btn.get_size()

				# Verifica se o clique está dentro do retângulo do botão
				if local_pos.x >= 0 and local_pos.x < size.x and local_pos.y >= 0 and local_pos.y < size.y:
					var tex: Texture2D = btn.texture_normal
					if tex == null:
						continue

					var img: Image = tex.get_image()
					if img == null:
						continue

					# Converte posição local do clique para posição dentro da textura
					var pixel_x: int = int(local_pos.x * img.get_width() / size.x)
					var pixel_y: int = int(local_pos.y * img.get_height() / size.y)

					# Pega cor do pixel
					var color: Color = img.get_pixel(pixel_x, pixel_y)

					# Verifica transparência (pixel-perfect click)
					if color.a > 0.1:
						print("Clique válido no botão: ", btn.name)
						btn_clique(btn)


func btn_clique(btn: TextureButton) -> void:
	print("Função do botão: ", btn.name)
	if btn.name == "BtnVoltar":
		GameManager.goto("MainMenu")
