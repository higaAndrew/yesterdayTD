class_name HealthComponent
extends Node

signal healed(heal: float, current_health: float)
signal took_damage(damage: float, current_health: float)
signal health_zero

@export var hitbox: CollisionShape2D
@export var hurt_sound: AudioStreamPlayer
@export var death_sound: AudioStreamPlayer

var parent: Area2D
var base_health: float
var current_health: float


## set health values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_health = parent.stats.base_health
	current_health = base_health
	
	GlobalScripts.verify(parent, hitbox, "hitbox")


## increase health
func increase_health(amount: float) -> void:
	current_health += amount


## decrease health
func decrease_health(amount: float) -> void:
	current_health -= amount


## reset health
func reset_health() -> void:
	current_health = base_health


## restore health
func restore_health(heal: float) -> void:
	current_health += heal
	
	healed.emit(heal, current_health)


## take damage and reduce health
func take_damage(damage: float) -> void:
	decrease_health(damage)
	took_damage.emit(damage, current_health)
	check_health_zero()


## check if health is gone
func check_health_zero() -> void:
	if max(0, current_health) == 0:
		health_zero.emit()


## play hurt sound
func play_hurt_sound() -> void:
	GlobalScripts.verify(parent, hurt_sound, "hurt_sound")
	if is_instance_valid(hurt_sound):
		hurt_sound.play()


## play death sound
func play_death_sound() -> void:
	GlobalScripts.verify(parent, death_sound, "death_sound")
	if is_instance_valid(death_sound):
		death_sound.play()


## the debugger gets pissy when you use set_disabled, so this is a passable workaround
func disable_hitbox() -> void:
	hitbox.global_position = Vector2(-64, -64)
	hitbox.set_deferred("disabled", true)
