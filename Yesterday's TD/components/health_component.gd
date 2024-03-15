class_name HealthComponent
extends Node

@export var damage_sound: AudioStreamPlayer2D
@export var death_sound: AudioStreamPlayer2D
@export var health := 100

var dead := false

func die() -> void:
	dead = true
	health = 0
	queue_free()
	if death_sound:
		death_sound.play()
