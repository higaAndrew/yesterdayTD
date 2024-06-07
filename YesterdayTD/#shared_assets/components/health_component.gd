class_name HealthComponent
extends Node

signal healed(heal: float, current_health: float)
signal took_damage(damage: float, current_health: float)
signal health_zero

@export var hurt_sound: AudioStreamPlayer
@export var death_sound: AudioStreamPlayer

var parent: Node2D
var base_health: float
var current_health: float


## set health values according to stats
func init(_parent: Node2D) -> void:
	parent = _parent
	base_health = parent.stats.base_health
	current_health = base_health


## increase health
func increase_health(amount: float) -> void:
	current_health += amount


## decrease health
func decrease_health(amount: float) -> void:
	current_health -= amount


## restore health
func restore_health(heal: float) -> void:
	current_health += heal
	
	healed.emit(heal, current_health)


## take damage and reduce health
func take_damage(damage: float) -> void:
	decrease_health(damage)
	
	if is_instance_valid(hurt_sound):
		hurt_sound.play()
	
	took_damage.emit(damage, current_health)


## check if health is gone
func check_health_zero() -> void:
	if max(0, current_health) == 0:
		health_zero.emit()
		death_sound.play()


## play hurt sound
func play_hurt_sound() -> void:
	GlobalScripts.verify(parent, hurt_sound, "hurt_sound")
	hurt_sound.play()


func play_death_sound() -> void:
	GlobalScripts.verify(parent, death_sound, "death_sound")
	death_sound.play()
