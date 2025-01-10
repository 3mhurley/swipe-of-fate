extends Node2D

@export var min_enemy_health: int = 5
@export var max_enemy_health: int = 10
@export var enemy_names: Array = ["Rosstoff", "Yanderin", "Welcox", "Anderan", "Dwellin"]

@onready var enemy_scene: PackedScene = preload("res://Sprites/enemy.tscn")

@onready var spawn_point = $CanvasLayer/Spawn
@onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void:

	var enemy: Enemy = enemy_scene.instantiate()
	var enemy_name: String = enemy_names.pick_random()
	var enemy_health: int = rng.randi_range(min_enemy_health, max_enemy_health)

	spawn_point.add_child(enemy)
	enemy.set_enemy_values(enemy_name, enemy_health, max_enemy_health)
	enemy.visible = true
