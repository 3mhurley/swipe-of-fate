extends Sprite2D

@export var key_name: String = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(key_name):
		print("Key pressed: ", key_name)
