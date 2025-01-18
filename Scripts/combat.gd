extends Node2D

@export var key_name: String = "block_right"
@export var damage_image_rotation: String = "Left"
@export var parriable: bool = false

@onready var damage_scene: PackedScene = preload("res://Sprites/damage.tscn")
@onready var damage: Damage = damage_scene.instantiate()
@onready var damage_sprite = damage.get_node("DamageImage/DamageImageSprite")
@onready var player_node = get_parent().get_node("Player")
@onready var opponent_node = get_parent().get_node("Opponent")
# @onready var attack_sfx = 


func create_damage() -> void:
	# damage = damage_scene.instantiate()
	damage_sprite.visible = false
	opponent_node.add_child(damage)


func damage_player() -> void:
	player_node.health -= 1
	player_node.get_node("DamageSFX").play()


func damage_opponent() -> void:
	opponent_node.get_node("Enemy").enemy_health -= 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("CombatTimer").wait_time = 4
	create_damage()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(key_name) and parriable == true:
		print("Key pressed: ", key_name)
		damage_sprite.visible = false
		parriable = false
		get_node("ParryingSFX").play()
		damage_opponent()
	pass


func _on_timer_timeout() -> void:

	if damage_image_rotation == "Right":
		damage_sprite.flip_h = true
	
	damage_sprite.visible = true
	parriable = true

	opponent_node.get_node("Enemy/EnemySounds/AttackingSFX").play()

	await get_tree().create_timer(1.5).timeout

	if is_instance_valid(damage) and parriable == true:
		damage_sprite.visible = false
		parriable = false
		damage_player()


func _on_button_pressed() -> void:
	get_node("CombatTimer").start()
	get_parent().get_node("CanvasLayer/StartButton").visible = false
