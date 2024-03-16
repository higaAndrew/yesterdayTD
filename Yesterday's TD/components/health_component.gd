class_name HealthComponent
extends Node

@export var damage_sound: AudioStreamPlayer
@export var death_sound: AudioStreamPlayer
@export var health := 100

var dead := false

func die() -> void:
	dead = true
	health = 0
	if death_sound:
		death_sound.play()
	get_parent().queue_free()
