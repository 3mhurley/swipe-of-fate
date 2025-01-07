class_name Enemy extends Node2D

@export var enemy_name: String = "Enemy Name"
@export var enemy_health: int = 3
@export var enemy_image_sprite: Node2D

@onready var enemy_name_label: Label = $EnemyName/EnemyNameLabel
@onready var enemy_health_label: Label = $EnemyHealth/EnemyHealthLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_name_label.set_text(enemy_name)
	enemy_health_label.set_text(str(enemy_health))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
