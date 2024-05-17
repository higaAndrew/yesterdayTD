class_name AttackComponent
extends Node2D

signal attacking

@export var attacker: Node2D
@export var rate_of_fire := 1.0
@export var attack_type: PackedScene
@export var projectile_speed := 1000
@export var projectile_damage := 1
@export var projectile_scale := 1.0
@export var projectile_pierce := 1
@export var animated_sprite: AnimatedSprite2D
@export var aim_component: AimComponent

@onready var muzzle_flash := $MuzzleFlash as AnimatedSprite2D
@onready var attack_sound := $ShootSound as AudioStreamPlayer
@onready var rate_of_fire_timer := $RateOfFireTimer as Timer

# dictionary of potential projectiles, might move these to call from the entities
var projectiles := {
	"snowball": preload("res://entities/projectiles/snowball.tscn"),
	"snowbomb": preload("res://entities/projectiles/snowbomb.tscn"),
}
var melee_attacks := {

}
var can_attack := true
var _position: Vector2
var _aim_component_position: Vector2
var map: Node2D
var projectilePath: CanvasLayer


# locate the parent map for spawning the projectiles into
func _ready() -> void:
	map = find_parent("Map")
	projectilePath = map.find_child("Projectiles")


# rotate towards target and attack
func aim_and_attack(delta: float) -> void:
	aim_component.rotate_towards_target(delta)
	if can_attack and aim_component.is_colliding():
		attack()


# attack
func attack() -> void:
	_aim_component_position = aim_component.get_reticle_position()
	can_attack = false
	for _muzzle in animated_sprite.get_children():
		_instantiate_attack(_muzzle.global_position)
	_play_animations("throw")
	_play_attack_sound()
	rate_of_fire_timer.start(rate_of_fire)


# enter the attacking state, which will have the entity send the type of attack to perform
func _instantiate_attack(muzzle_position: Vector2) -> void:
	_position = muzzle_position
	attacking.emit()


# general projectile attack initialization
func throw_projectile_attack(projectile_type: String) -> void:
	var projectile: Area2D = projectiles[projectile_type].instantiate()
	# spawn projectiles in the map
	if is_instance_valid(map):
		projectilePath.add_child(projectile)
	# make the attacker the parent (this shouldn't ever really happen)
	else:
		owner.add_child(projectile)
	projectile.start(_position, attacker.rotation, projectile_speed, projectile_damage, projectile_scale, projectile_pierce, _aim_component_position)
	projectile.collision_mask = aim_component.collision_mask


# may want to separate attack types into their own components?
func shoot_projectile_attack(projectile_type: String) -> void:
	pass


func melee_attack(melee_type: String) -> void:
	pass


# play one of animated_sprite's animations
func _play_animations(animation_name: String) -> void:
	animated_sprite.frame = 0
	muzzle_flash.frame = 0
	animated_sprite.play(animation_name)
	muzzle_flash.play(animation_name)


# play an attack sound, if one is set
func _play_attack_sound() -> void:
	if is_instance_valid(attack_sound):
		attack_sound.play()


# reset rate of fire cooldown
func _on_rate_of_fire_timer_timeout() -> void:
	can_attack = true


# return the animated_sprite to idle after shooting
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation.contains("throw"):
		_play_animations("idle")
