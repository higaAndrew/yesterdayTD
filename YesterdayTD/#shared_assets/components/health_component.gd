class_name HealthComponent
extends Node


signal took_damage(damage: float, current_health: float)
signal health_depleted

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
func restore_health(amount: float) -> void:
	current_health += amount


## take damage and reduce health
func take_damage(damage: float) -> void:
	decrease_health(damage)
	took_damage.emit(damage, current_health)
	check_health_depleted()


## check if health is gone
func check_health_depleted() -> void:
	if max(0, current_health) == 0:
		health_depleted.emit()


## play/verify hurt sound
func play_hurt_sound() -> void:
	GlobalScripts.verify(parent, hurt_sound, "hurt_sound")
	
	if is_instance_valid(hurt_sound):
		hurt_sound.play()


## play/verify death sound
func play_death_sound() -> void:
	GlobalScripts.verify(parent, death_sound, "death_sound")
	
	if is_instance_valid(death_sound):
		death_sound.play()
