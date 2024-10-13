extends CharacterBody2D

@onready var wall_sprite = $main_room
const SPEED = 40.0
var rotation_speed = 3.5

@export var line_scene: PackedScene
@onready var ray_cast = $RayCast2D

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

func create_dot(point, coeff):
	#var player_position = self.position
	var line_instance = line_scene.instantiate()
	line_instance.position = Vector2(point)
	coeff = coeff*8
	line_instance.default_color = Color(255/coeff, 255/coeff, 255/coeff)
	
	get_parent().add_child(line_instance)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var player_position = self.position
		var i = -60
		while true:
			if i > 60:
				break
			ray_cast.rotation_degrees = i
			var point = ray_cast.get_collision_point()
			
			var coeff = ((player_position[0]-point[0])**2+(player_position[1]-point[1])**2)**0.5
			
			if point:
				create_dot(point, coeff)
				print(point)
				
			await get_tree().create_timer(delta).timeout
			i += 1
		ray_cast.rotation_degrees = 0
