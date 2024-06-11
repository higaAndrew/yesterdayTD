class_name AttackComponent
extends Node
## originally this was only for attack cooldown, but i wanted to make the attack spawning a bit easier

@export_enum("0", "1", "2") var attack_number: int = 0
@export_enum("Projectiles", "Effects") var layer_id: String = "Projectiles"
@export var muzzle: Marker2D
@export var sightline: RayCast2D
@export var targets: TargetsComponent

var parent: Area2D
var stats: Resource
var base_attack_cooldown: float
var current_attack_cooldown: float

var muzzle_position: Vector2
var destination: Vector2
var layer: CanvasLayer


## set attack speed values according to stats
## select the appropriate attack stats file
func init(_parent: Area2D) -> void:
	parent = _parent
	match attack_number:
		0:
			base_attack_cooldown = parent.attack0_stats.base_attack_cooldown
		1:
			base_attack_cooldown = parent.attack1_stats.base_attack_cooldown
		2:
			base_attack_cooldown = parent.attack2_stats.base_attack_cooldown
		_:
			printerr("%s has no attack%s_stats!" % [parent, attack_number])
	layer = find_parent("Canvas").find_child(layer_id)
	current_attack_cooldown = base_attack_cooldown
	
	GlobalScripts.verify(parent, muzzle, "muzzle")
	GlobalScripts.verify(parent, sightline, "sightline")


## ATTACK INIT STUFF
func init_projectile(attack: Area2D) -> void:
	muzzle_position = muzzle.global_position
	destination = sightline.to_global(sightline.target_position)
	#destination = targets.current_target.global_position
	
	layer.add_child(attack)
	attack.velocity.set_global_position(muzzle_position)
	attack.velocity.set_rotation(parent.rotation)
	attack.velocity.set_direction(destination)
	attack.velocity.set_velocity()


## ATTACK COOLDOWN STUFF
## add attack cooldown
func increase_attack_cooldown(amount: float) -> void:
	current_attack_cooldown += amount


## subtract attack cooldown
func decrease_attack_cooldown(amount: float) -> void:
	current_attack_cooldown -= amount


## multiply attack cooldown
func multiply_attack_cooldown(amount: float) -> void:
	current_attack_cooldown *= amount


## divide attack cooldown
func divide_attack_cooldown(amount: float) -> void:
	current_attack_cooldown /= amount


## restore attack cooldown to base value
func reset_attack_cooldown() -> void:
	current_attack_cooldown = base_attack_cooldown