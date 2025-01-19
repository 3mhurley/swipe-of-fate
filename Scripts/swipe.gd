extends Camera2D

@onready var drag_length: int = 10
@onready var start_position: Vector2
@onready var current_position: Vector2
@onready var final_position: Vector2
@onready var swiping: bool = false
@onready var swiping_direction: String

# func get_direction(start_pos: Vector2, end_pos: Vector2) -> String:
	# var direction_vector: Vector2

	# direction_vector = end_pos - start_pos

	# if abs(direction_vector.x) > abs(direction_vector.y):
	# 	if direction_vector.x > 0:
	# 		return "right"
	# 	elif direction_vector.x < 0:
	# 		return "left"
	# else:
	# 	if direction_vector.y > 0:
	# 		return "down"
	# 	elif direction_vector.y < 0:
	# 		return "up"

	# return "none"  # No significant movement in either axis

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# if Input.is_action_just_pressed("press"):
	# 	if !swiping:
	# 		swiping = true
	# 		start_position = get_global_mouse_position()

	# if Input.is_action_just_released("press"):
	# 	if swiping:
	# 		final_position = get_global_mouse_position()
	# 		swiping = false
	# 		swiping_direction = get_direction(start_position, final_position)

	# 		if swiping_direction != "none":
	# 			print("Swiped " + swiping_direction)
	pass
