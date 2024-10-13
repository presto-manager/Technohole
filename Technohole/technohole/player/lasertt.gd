extends Node2D


var distance
func _process(delta):
	if $RayCast2D.get_collider():
		distance = transform.origin.distance_to($RayCast2D.get_collision_point())
		$Testlaser.scale.x = distance
	else:
		$Testlaser.scale.x = $RayCast2D.cast_to_x
