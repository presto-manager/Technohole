extends Node2D

# Узел Line2D, который отрисует линию
onready var line_2d = $Line2D

# Массив точек для линии
var points = []

# Длина линии
var line_length = 300

# Количество сегментов (чем больше, тем более плавная кривая)
var num_segments = 20

# Амплитуда кривизны
var curve_amplitude = 50

func _ready():
	# Инициализация пустой линии
	line_2d.clear_points()

func _process(delta):
	# Проверяем нажатие клавиши (например, пробел через ui_accept)
	if Input.is_action_just_pressed("ui_accept"):
		create_curved_line()

# Функция для создания искривленной линии
func create_curved_line():
	points.clear()

	# Определяем начальную
