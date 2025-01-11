extends Camera2D

var drag_length: int = 10
var start_position: Vector2
var current_position: Vector2
var final_position: Vector2
var swiping = false

func get_direction(start_pos: Vector2, end_pos: Vector2) -> String:
	var direction_vector: Vector2

	direction_vector = end_pos - start_pos

	if direction_vector.x > 0:
		return "Right"
	elif direction_vector.x < 0:
		return "Left"
	else:
		return "Straight Up and Down"  # No horizontal movement

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("press"):
		if !swiping:
			swiping = true
			start_position = get_global_mouse_position()
			# print("Start position: ", start_position)

	if Input.is_action_just_released("press"):
		if swiping:
			final_position = get_global_mouse_position()
			# print("Final position: ", final_position)
			swiping = false
			print("Swiped " + get_direction(start_position, final_position))
