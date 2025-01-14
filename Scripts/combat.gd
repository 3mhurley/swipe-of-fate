extends Node2D

@onready var damage_scene: PackedScene = preload("res://Sprites/damage.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Timer").wait_time = 4
	get_node("Timer").start()

func add_damage_sprite() -> void:
	var damage: Damage = damage_scene.instantiate()
	var damage_image_rotation: String = "Left"

	add_child(damage)
	damage.set_damage_values(damage_image_rotation)
	damage.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print("Timer timeout")
	# add_damage_sprite()

	var damage: Damage = damage_scene.instantiate()
	var damage_image_rotation: String = "Left"

	add_child(damage)
	damage.set_damage_values(damage_image_rotation)
	damage.visible = true

	var remove_timer = Timer.new()
	remove_timer.wait_time = 1.5
	remove_timer.timeout.connect(_on_RemoveTimer_timeout)
	add_child(remove_timer)
	remove_timer.start()

func _on_RemoveTimer_timeout():
	# Remove the sprite
	get_node("Sprite").queue_free() 

	# Remove the remove timer
	queue_free()
