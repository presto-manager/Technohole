extends Area2D

# Ссылка на иконку взаимодействия
@onready var interaction_icon = $InteractionIcon
# Ссылка на персонажа
@onready var player = get_node("/player/player.tscn") 

func _ready():
	# Скрываем иконку при старте
	pass
	#interaction_icon.visible = false
