extends CharacterBody2D

@onready var wall_sprite = $main_room
var SPEED = 50.0
var rotation_speed = 4
var flag = 1

@export var line_scene: PackedScene
@onready var ray_cast = $RayCast2D
@onready var audio_player = $AudioStreamPlayer2D  # Убедитесь, что путь к узлу правильный
@onready var sprite = $AnimatedSprite2D  # Убедитесь, что путь к узлу правильный

var queue = []
func queue_add(elem, queue):
	if elem not in queue:
		queue.append(elem)

func discolor_point(point):
	var line_instance = line_scene.instantiate()
	line_instance.position = Vector2(point)
	line_instance.default_color = Color(40, 40, 40)
	get_parent().add_child(line_instance)
	
func _physics_process(delta: float) -> void:
	print(rotation)
	
	if Input.is_action_pressed("ui_up"):
		velocity.x = cos(rotation)
		velocity.y = sin(rotation) 

		sprite.play("run")	
	else:
		velocity.x = move_toward(velocity.y, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

		sprite.play("run")
		
	#if Input.is_action_pressed("ui_down"):
		#rotation = lerp_angle(rotation, rotation-180, rotation_speed * delta)
#
		#await get_tree().create_timer(1).timeout
		#sprite.play("run")

		
	
  # Get the input direction and handle the movement/deceleration.
  # As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		rotation += delta * direction
		sprite.play("run")
	#else:
		#rotation = lerp_angle(rotation, 0, rotation_speed * delta)
		#sprite.play("run")
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	move_and_slide()
	
	
	
func create_dot(point, coeff, time):

	var line_instance = line_scene.instantiate()
	line_instance.position = Vector2(point)
	coeff = coeff*8
	line_instance.default_color = Color(151/coeff, 51/coeff, 255/coeff)
	get_parent().add_child(line_instance)
	queue_add(point,queue)
	
	await get_tree().create_timer(time).timeout
	discolor_point(point) # Удаляем объект
	

func _ready() -> void:
	ray_cast.visible = false
	sprite.play("stand")

func _process(delta):
	
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		sprite.play("stand")
		
	if Input.is_action_just_pressed("scan_left"):
		SPEED = 8.0
		rotation_speed = 0.25
		ray_cast.target_position.x = 95
		ray_cast.visible = true
		audio_player.play()  # Проигрываем музыку
		var player_position = self.position
		var i = -50
		var time = 5
		while true:
			
			if i > 50:
				break
			ray_cast.rotation_degrees = i
			var point = ray_cast.get_collision_point()
			
			var coeff = ((player_position[0]-point[0])**2+(player_position[1]-point[1])**2)**0.5
			
			if point:
				create_dot(point, coeff, time)
				
			await get_tree().create_timer(delta).timeout
			i += 2
			time += 0.25
		ray_cast.rotation_degrees = 0
		ray_cast.visible = false
		SPEED = 40.0
		rotation_speed = 3.5
