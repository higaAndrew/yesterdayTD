class_name EnemyDie
extends State

## TODO die state
signal died

var animations: AnimatedSprite2D
var health: HealthComponent
var path_movement: PathMovementComponent


var death_sound: AudioStreamPlayer
var animation_done: bool
var sound_done: bool


func enter() -> void:
	animations = parent.animations
	health = parent.health
	path_movement = parent.path_movement
	death_sound = health.death_sound
	
	animation_done = false
	sound_done = false
	
	GlobalScripts.verify(parent, animations, "animations")
	GlobalScripts.verify(parent, health, "health")
	GlobalScripts.verify(parent, path_movement, "path_movement")
	
	if is_instance_valid(animations):
		GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	if is_instance_valid(death_sound):
		GlobalScripts.connect_signal(death_sound, "finished", self, "_on_death_sound_finished")
		print('valid')
	
	animations.play("die")
	
	health.disable_hitbox()
	health.play_death_sound()
	died.emit()


func _on_animation_finished() -> void:
	if animations.animation == ("die"):
		animation_done = true
		check_delete()


func _on_death_sound_finished() -> void:
	sound_done = true
	check_delete()
	
func check_delete() -> void:
	if animation_done and sound_done:
		path_movement.path.queue_free()
	if animation_done and not is_instance_valid(death_sound) and not sound_done:
		path_movement.path.queue_free()
		print("no!!!")
