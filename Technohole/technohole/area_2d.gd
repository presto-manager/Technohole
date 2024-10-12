extends Area2D

# Ссылка на иконку взаимодействия
@onready var interaction_icon = $InteractionIcon
# Ссылка на персонажа
@onready var player = get_node("/player/player.tscn") 

func _ready():
	# Скрываем иконку при старте
	interaction_icon.visible = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"): # Проверяем, что это персонаж
		interaction_icon.visible = true # Показываем иконку

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"): # Проверяем, что это персонаж
		interaction_icon.visible = false # Скрываем иконку

func _process(delta):
	if interaction_icon.visible and Input.is_action_just_pressed("ui_accept"): # Проверяем нажатие клавиши
		interact() # Вызываем функцию взаимодействия

func interact():
	# Логика взаимодействия с объектом
	print("Взаимодействие с объектом!")
