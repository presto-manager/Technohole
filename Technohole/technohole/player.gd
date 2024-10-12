extends CharacterBody2D

@onready var wall_sprite = $main_room
const SPEED = 100.0
var rotation_speed = 13.5

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

func create_dot(point):
	#var player_position = self.position
	var line_instance = line_scene.instantiate()
	line_instance.position = Vector2(point)
	get_parent().add_child(line_instance)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and ray_cast.is_colliding():
		var point = ray_cast.get_collision_point()
		create_dot(point)
