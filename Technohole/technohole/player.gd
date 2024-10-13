extends CharacterBody2D

@onready var wall_sprite = $main_room
const SPEED = 40.0
var rotation_speed = 3.5

@export var line_scene: PackedScene
@onready var ray_cast = $RayCast2D


var queue = [] # with len = 100
var points = []
const LEN_OF_QUEUE = 300
func queue_add(elem, queue):
	if elem in queue:
		return
	if len(queue) == LEN_OF_QUEUE:
		discolor_point(queue[0])
		queue.remove_at(0)
		queue.push_back(elem)
	else:
		queue.append(elem)

func discolor_point(point):
	var line_instance = line_scene.instantiate()
	line_instance.position = Vector2(point)
	line_instance.default_color = Color(0, 0, 0)
	get_parent().add_child(line_instance)

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
  # Get the input direction and handle the movement/deceleration.
  # As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		var target_rotation = velocity.angle()
		rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
	move_and_slide()
	
	
	
func create_dot(point, coeff, time):


	var line_instance = line_scene.instantiate()
	line_instance.position = Vector2(point)
	coeff = coeff*8
	line_instance.default_color = Color(255/coeff, 255/coeff, 255/coeff)
	get_parent().add_child(line_instance)
	queue_add(point,queue)
	points.append(line_instance)
	
	
	var timer = get_tree().create_timer(time)  # Создаем таймер на 5 секунд
	await timer.timeout  # Ожидаем завершения таймера
	line_instance.queue_free()  # Удаляем объект
	

func _ready() -> void:
	ray_cast.visible = false

func _process(delta):
	
	#var timer = get_tree().create_timer(5.0)
		

	if Input.is_action_just_pressed("ui_accept"):
		ray_cast.visible = true
		var player_position = self.position
		var i = -60
		var time = 5
		while true:
			
			if i > 60:
				break
			ray_cast.rotation_degrees = i
			var point = ray_cast.get_collision_point()
			
			var coeff = ((player_position[0]-point[0])**2+(player_position[1]-point[1])**2)**0.5
			
			if point:
				create_dot(point, coeff, time)
				print(point)
				
			await get_tree().create_timer(delta).timeout
			i += 1
			time += 1
		ray_cast.rotation_degrees = 0
		ray_cast.visible = false
