extends Node2D

# Задаем переменные для шейдера
var line_color : Color = Color(0.0, 0.4, 0.0, 1.0)
var beam_color : Color = Color(0.5, 1.0, 0.5, 1.0)
var trail_color : Color = Color(0.0, 0.5, 0.0, 1.0)
var blip_color : Color = Color(0.5, 1.0, 0.5, 1.0)
var show_edges : bool = false
var range_lines : float = 4.0
var sector_lines : float = 4.0
var line_width : float = 0.01
var beam_angle : float = 0.2
var beam_width : float = 0.003
var trail_width : float = 0.5
var blip_size : float = 0.1
var blip_softness : float = 0.4
var blip_presistence : float = 2.0
var blip_position : Vector2 = Vector2(0.5, 0.5)

# Метод для обновления шейдера
func _ready():
	var shader_material = ShaderMaterial.new()
	shader_material.shader = load("res://path_to_your_shader.shader") # Укажите путь к вашему шейдеру
	shader_material.set_shader_param("line_color", line_color)
	shader_material.set_shader_param("beam_color", beam_color)
	shader_material.set_shader_param("trail_color", trail_color)
	shader_material.set_shader_param("blip_color", blip_color)
	shader_material.set_shader_param("show_edges", show_edges)
	shader_material.set_shader_param("range_lines", range_lines)
	shader_material.set_shader_param("sector_lines", sector_lines)
	shader_material.set_shader_param("line_width", line_width)
	shader_material.set_shader_param("beam_angle", beam_angle)
	shader_material.set_shader_param("beam_width", beam_width)
	shader_material.set_shader_param("trail_width", trail_width)
	shader_material.set_shader_param("blip_size", blip_size)
	shader_material.set_shader_param("blip_softness", blip_softness)
	shader_material.set_shader_param("blip_presistence", blip_presistence)
	shader_material.set_shader_param("blip_position", blip_position)

	$YourSprite.material = shader_material # Примените материал к вашему спрайту или объекту
