class_name AttackComponent
extends Node
## originally this component was only for attack cooldown, but i wanted to make the attack spawning a bit easier
## i combined these because if you have multiple attacks, then you'd always have both an attack cooldown component
## and an attack component, so i killed 2 birdies with one rock
## is there a more graceful solution? almost definitely. am I going to find it? hell no

## nvm i did it


@export var muzzle0: Marker2D
@export var muzzle1: Marker2D
@export var muzzle2: Marker2D
@export var muzzle3: Marker2D

var parent: Area2D
var projectiles: CanvasLayer
var explosions: CanvasLayer


## get parent components and init canvas layers
func init(_parent: Area2D) -> void:
	parent = _parent
	
	init_layers()


## set up canvas layers for attacks
func init_layers() -> void:
	projectiles = find_parent("Canvas").find_child("Projectiles")
	explosions = find_parent("Canvas").find_child("Explosions")


## assign a given attack to a layer
func assign_layer(attack: Area2D) -> void:
	var layer: CanvasLayer
	
	if attack.is_in_group("projectiles"):
		layer = projectiles
		layer.add_child(attack)
	
	elif attack.is_in_group("explosions"):
		layer = explosions
		layer.add_child(attack)


## given a projectile, init all its velocity related values, and add it to the selected canvas layer
func init_projectile(attack_number: int, projectile: Area2D) -> void:
	var muzzle = get("muzzle%s" % attack_number)
	var muzzle_position: Vector2
	if not is_instance_valid(muzzle):
		muzzle_position = parent.global_position
	else:
		muzzle_position = muzzle.global_position
	
	assign_layer(projectile)
	projectile.global_position = muzzle_position
	projectile.rotation = parent.rotation
	projectile.velocity.set_velocity()


## given an explosion, init its location and rotation, and add it to the proper canvas layer
## also, make sure the explosion originates at the center of the target, not at the point of contactx
func init_explosion(explosion: Area2D) -> void:
	assign_layer(explosion)
	explosion.global_position = parent.hitbox.current_collision.global_position
	explosion.rotation = parent.rotation
