extends Node2D

@onready var damage_scene: PackedScene = preload("res://Sprites/damage.tscn")

@onready var opponent_node = get_parent().get_node("Opponent")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("CombatTimer").wait_time = 4
	get_node("CombatTimer").start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print("Timer timeout")
	# add_damage_sprite()

	var damage: Damage = damage_scene.instantiate()
	var damage_image_rotation: String = "Left"

	opponent_node.add_child(damage)
	damage.set_damage_values(damage_image_rotation)
	damage.visible = true

	await get_tree().create_timer(1.5).timeout
	print("remove timer")

	if is_instance_valid(damage):
		damage.queue_free()
