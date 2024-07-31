class_name SoundComponent
extends Node


var parent: Node


func init(_parent: Node) -> void:
	parent = _parent


func play_build_sound() -> void:
	if parent is BuildMenu:
		SoundManager.play_sound("tower_build_sounds")


func play_death_sound() -> void:
	if parent is Enemy:
		if parent.is_in_group("robots"):
			SoundManager.play_sound_random_pitch("robot_death_sounds")
		elif parent.is_in_group("vehicles"):
			SoundManager.play_sound_random_pitch("vehicle_death_sounds")
	elif parent is Objective:
		SoundManager.play_sound("objective_death_sounds")


func play_explosion_sound() -> void:
	if parent is Attack:
		if parent is SnowbombExplosion:
			SoundManager.play_sound_random_pitch("snowbomb_explosion_sounds")


func play_hit_sound() -> void:
	if parent is Attack:
		return


func play_hurt_sound() -> void:
	if parent is Enemy:
		if parent.is_in_group("robots"):
			SoundManager.play_sound_random_pitch("robot_hurt_sounds")
		elif parent.is_in_group("vehicles"):
			SoundManager.play_sound_random_pitch("vehicle_hurt_sounds")
	elif parent is Objective:
		SoundManager.play_sound("objective_hurt_sounds")
