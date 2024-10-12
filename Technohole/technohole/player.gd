extends CharacterBody2D


const ACCELERATION = 500
const MAX_SPEED = 60
var motion = Vector2.ZERO

var speed = 150
var jumpForce = 500
var gravity = 700
var rotation_speed = 5.0
var vel = Vector2()


func _physics_process(delta: float) -> void:
	


	const SPEED = 300.0

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
		velocity = velocity.normalized() * speed
		var target_rotation = velocity.angle()
		rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)


	move_and_slide()

#






## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
