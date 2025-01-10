@tool
class_name Player extends Node2D

@export var max_health: int = 10
@export var health: int = 10

func set_health(_health: int, _max_health: int) -> void:
	max_health = _max_health
	health = _health
	update_health_bar()

func update_health_bar() -> void:
	if ($CanvasLayer/HealthBar as ProgressBar).max_value != max_health:
		($CanvasLayer/HealthBar as ProgressBar).max_value = max_health
	if ($CanvasLayer/HealthBar as ProgressBar).value != health:
		($CanvasLayer/HealthBar as ProgressBar).value = health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_health_bar()
