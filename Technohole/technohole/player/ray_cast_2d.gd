extends RayCast2D

@onready var beam_mash = $Testlaser


func _process(delta: float) -> void:
	var cast_point
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		beam_mash.scale.x = cast_point.x
		beam_mash.position.x = cast_point.x/2
	else:
		beam_mash.scale.x = self.target_position.x
		beam_mash.position.x = 47.524
		
	
	
	
