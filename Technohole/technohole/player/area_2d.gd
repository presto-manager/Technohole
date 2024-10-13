extends Area2D


# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	var object_id = body.get_object_id()

func _ready() -> void:
	pass
	#connect("body_entered", self, _on_body_entered)
	


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
