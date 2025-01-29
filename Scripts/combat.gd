extends Node2D

@export var key_name: String = "block_right"
@export var damage_image_rotation: String = "Left"
@export var parriable: bool = false
@export var kill_count: int = 0

@onready var enemy_scene: PackedScene = preload("res://Sprites/enemy.tscn")
@onready var enemy: Enemy
@onready var enemy_sfx: AudioStreamPlayer2D

@onready var damage_scene: PackedScene = preload("res://Sprites/damage.tscn")
@onready var damage: Damage
@onready var damage_sprite: Sprite2D
@onready var damage_directions: Array = ["Left", "Right"]

@onready var player_node: Node2D = get_parent().get_node("Player")
@onready var opponent_node: Node2D = get_parent().get_node("Opponent")
# @onready var attack_sfx = 

@onready var rng = RandomNumberGenerator.new()
@onready var dragging = false
@onready var mouse_start_position: Vector2
@onready var mouse_end_position: Vector2
@onready var dragging_direction: String


func create_enemy() -> void:
	enemy = enemy_scene.instantiate()
	opponent_node.add_child(enemy)
	enemy_sfx = enemy.get_node("EnemySounds/AttackingSFX")


func create_damage() -> void:
	damage = damage_scene.instantiate()
	opponent_node.add_child(damage)
	damage_sprite = damage.get_node("DamageImage/DamageImageSprite")
	damage_sprite.visible = false


func damage_player() -> void:
	player_node.health -= 1
	player_node.get_node("DamageSFX").play()

	get_node("CombatTimer").wait_time = rng.randi_range(1, 5)


func damage_opponent() -> void:
	enemy.enemy_health -= 1

	if enemy.enemy_health <= 0:
		get_node("CombatTimer").stop()
		opponent_node.get_node("Enemy").queue_free()
		opponent_node.get_node("Damage").queue_free()

		if kill_count < 3:
			kill_count += 1
			print("Kill count: " + str(kill_count))
			await get_tree().create_timer(3).timeout
			start_game()
		else:
			print("Kill count: " + str(kill_count))
			await get_tree().create_timer(3).timeout
			get_parent().get_node("CanvasLayer/WinScreen").visible = true
	else:
		get_node("CombatTimer").wait_time = rng.randi_range(1, 5)


func get_direction(start_pos: Vector2, end_pos: Vector2) -> String:
	var direction_vector: Vector2

	direction_vector = end_pos - start_pos

	if abs(direction_vector.x) > abs(direction_vector.y):
		if direction_vector.x > 0:
			return "Right"
		elif direction_vector.x < 0:
			return "Left"
	# else:
	# 	if direction_vector.y > 0:
	# 		return "Down"
	# 	elif direction_vector.y < 0:
	# 		return "Up"

	return "None"  # No significant movement in either axis


func start_game() -> void:
	create_enemy()
	create_damage()
	get_node("CombatTimer").wait_time = 2
	get_node("CombatTimer").start()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT  and parriable == true:
		# Start dragging
		if not dragging and event.pressed:
			dragging = true
			mouse_start_position = get_global_mouse_position()

		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false
			mouse_end_position = get_global_mouse_position()

			dragging_direction = get_direction(mouse_start_position, mouse_end_position)

			if dragging_direction != "None":
				print("Dragged " + dragging_direction)

				if dragging_direction != damage_image_rotation:
					print("Parried")
					damage_sprite.visible = false
					parriable = false
					get_node("ParryingSFX").play()
					damage_opponent()



func _on_timer_timeout() -> void:
	var damage_direction: String = damage_directions.pick_random()
	damage_image_rotation = damage_direction
	print(damage_image_rotation)

	match damage_direction:
		"Left":
			damage_sprite.flip_h = false
		"Right":
			damage_sprite.flip_h = true
	pass

	damage_sprite.visible = true
	parriable = true

	enemy_sfx.play()

	await get_tree().create_timer(1).timeout

	if is_instance_valid(damage) and parriable == true:
		damage_sprite.visible = false
		parriable = false
		damage_player()


func _on_button_pressed() -> void:
	get_parent().get_node("CanvasLayer/StartButton").visible = false

	start_game()
