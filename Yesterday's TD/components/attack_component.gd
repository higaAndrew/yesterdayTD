class_name AttackComponent
extends Node2D

signal attacking

@export var attacker: Node2D
@export var rate_of_fire := 1.0
@export var attack_type: PackedScene
@export var projectile_speed := 1000
@export var projectile_damage := 1
@export var projectile_scale := 1.0
@export var projectile_penetration := 1
@export var animated_sprite: AnimatedSprite2D
@export var aim_component: AimComponent

@onready var muzzle_flash := $MuzzleFlash as AnimatedSprite2D
@onready var attack_sound := $ShootSound as AudioStreamPlayer
@onready var rate_of_fire_timer := $RateOfFireTimer as Timer

var projectiles := {
	"snowball": preload("res://entities/projectiles/snowball.tscn"),
}
var melee_attacks := {

}
var can_attack := true
var _position: Vector2
var map: Node


func _ready() -> void:
	map = find_parent("Map")


func aim_and_attack(delta: float) -> void:
	# rotate towards target and attack
	aim_component.rotate_towards_target(delta)
	if can_attack and aim_component.is_colliding():
		attack()


func attack() -> void:
	# attack
	can_attack = false
	for _muzzle in animated_sprite.get_children():
		_instantiate_attack(_muzzle.global_position)
	_play_animations("throw")
	_play_attack_sound()
	rate_of_fire_timer.start(rate_of_fire)


func _instantiate_attack(muzzle_position: Vector2) -> void:
	_position = muzzle_position
	attacking.emit()


func throw_projectile_attack(projectile_type: String) -> void:
	var projectile: Area2D = projectiles[projectile_type].instantiate()
	if is_instance_valid(map):
		map.add_child(projectile)
	else:
		owner.add_child(projectile)
	projectile.start(_position, attacker.rotation, projectile_speed, projectile_damage, projectile_scale, projectile_penetration)
	projectile.collision_mask = aim_component.collision_mask


func shoot_projectile_attack(projectile_type: String) -> void:
	pass


func melee_attack(melee_type: String) -> void:
	pass


func _play_animations(animation_name: String) -> void:
	# play one of animated_sprite's animations
	animated_sprite.frame = 0
	muzzle_flash.frame = 0
	animated_sprite.play(animation_name)
	muzzle_flash.play(animation_name)


func _play_attack_sound() -> void:
	if is_instance_valid(attack_sound):
		attack_sound.play()


func _on_rate_of_fire_timer_timeout() -> void:
	# reset rate of fire cooldown
	can_attack = true


func _on_animated_sprite_2d_animation_finished() -> void:
	# return the animated_sprite to idle after shooting
	if animated_sprite.animation.contains("throw"):
		_play_animations("idle")
