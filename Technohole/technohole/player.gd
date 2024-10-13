extends CharacterBody2D

@onready var wall_sprite = $main_room
<<<<<<< Updated upstream
const SPEED = 100.0
var rotation_speed = 13.5
=======
var SPEED = 50.0
var rotation_speed = 4
var flag = 1
>>>>>>> Stashed changes

@export var line_scene: PackedScene
@onready var ray_cast = $RayCast2D

func _physics_process(delta: float) -> void:
	print(rotation)
	
<<<<<<< Updated upstream
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
=======
	if Input.is_action_pressed("ui_up"):
		velocity.x = cos(rotation)
		velocity.y = sin(rotation) 

		sprite.play("run")	
>>>>>>> Stashed changes
	else:
		velocity.x = move_toward(velocity.y, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
<<<<<<< Updated upstream
=======

		sprite.play("run")
		
	#if Input.is_action_pressed("ui_down"):
		#rotation = lerp_angle(rotation, rotation-180, rotation_speed * delta)
#
		#await get_tree().create_timer(1).timeout
		#sprite.play("run")

		
>>>>>>> Stashed changes
	
  # Get the input direction and handle the movement/deceleration.
  # As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
<<<<<<< Updated upstream
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
=======
		rotation += delta * direction
		sprite.play("run")
	#else:
		#rotation = lerp_angle(rotation, 0, rotation_speed * delta)
		#sprite.play("run")
>>>>>>> Stashed changes
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
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
