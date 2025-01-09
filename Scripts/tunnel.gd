extends Node2D

@onready var enemy_scene: PackedScene = preload("res://Sprites/enemy.tscn")

@onready var spawn_point = $CanvasLayer/Spawn
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	spawn_point.add_child(enemy)
	enemy.set_enemy_values("Knight", 10)
	enemy.visible = true

