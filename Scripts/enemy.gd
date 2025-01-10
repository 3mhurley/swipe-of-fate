@tool
class_name Enemy extends Node2D

@export var enemy_name: String = "Enemy Name"
@export var enemy_health: int = 3
@export var enemy_max_health: int = 10
@export var enemy_image_sprite: Node2D

@onready var enemy_name_label: Label = $EnemyName/EnemyNameLabel
@onready var enemy_health_label: Label = $EnemyHealth/EnemyHealthLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_enemy_values(enemy_name, enemy_health, enemy_max_health)
	visible = false

func set_enemy_values(_name: String, _health: int, _max_health: int):
	enemy_name = _name
	enemy_health = _health
	enemy_max_health = _max_health
	#enemy_image_sprite = _sprite

	_update_graphics()

func _update_graphics():
	if enemy_name_label.get_text() != enemy_name:
		enemy_name_label.set_text(enemy_name)
	if enemy_health_label.get_text() != str(enemy_health):
		enemy_health_label.set_text(str(enemy_health))

	if ($EnemyHealth/EnemyHealthBar as ProgressBar).value != enemy_health:
		($EnemyHealth/EnemyHealthBar as ProgressBar).value = enemy_health
	if ($EnemyHealth/EnemyHealthBar as ProgressBar).max_value != enemy_max_health:
		($EnemyHealth/EnemyHealthBar as ProgressBar).max_value = enemy_max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_update_graphics()


func _on_damage_enemy_button_pressed() -> void:
	enemy_health = enemy_health - 1
	_update_graphics()
