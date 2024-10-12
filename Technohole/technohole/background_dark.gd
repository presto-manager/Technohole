extends Node2D

func _ready():
	# Создаем новый спрайт для фона
	var background = Sprite2D.new()
	
	# Загружаем текстуру (замените "res://path_to_your_texture.png" на путь к вашей текстуре)
	background.texture = preload("res://blackhole.png")
	
	# Устанавливаем позицию фона (например, в центр экрана)
	background.position = Vector2(0,0)
	
	# Добавляем спрайт в сцену
	add_child(background)
