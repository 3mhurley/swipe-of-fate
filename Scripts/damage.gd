class_name Damage extends Node2D

# @export var damage_image_sprite: Sprite2D
@export var damage_image_rotation: String = "Left"

@onready var damage_image_sprite: Sprite2D = $DamageImage/DamageImageSprite

func _ready() -> void:
	set_damage_values(damage_image_rotation)
	visible = false

func set_damage_values( _image_rotation: String):
	damage_image_rotation = _image_rotation

	_update_graphics()

func _update_graphics():
	if damage_image_rotation == "Right":
		damage_image_sprite.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_update_graphics()
