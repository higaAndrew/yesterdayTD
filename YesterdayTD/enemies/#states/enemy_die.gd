extends State

signal died

var hitbox: Hitbox
var animations: AnimatedSprite2D
var death_sound: AudioStreamPlayer
var health: HealthComponent
var layers: LayersComponent
var path_movement: PathMovementComponent

var animation_done := false
var sound_done := false


## get parent's components
func enter() -> void:
	hitbox = parent.hitbox
	
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	death_sound = parent.death_sound
	GlobalScripts.connect_signal(death_sound, "finished", self, "_on_death_sound_finished")
	
	health = parent.health
	path_movement = parent.path_movement
	if not parent.stats.children.is_empty():
		layers = parent.layers
		layers.spawn_children()
		
	GlobalScripts.play_animation(parent, animations, "die")
	hitbox.disable_hitbox()
	health.play_death_sound()
	died.emit()


## handle death animation finishing
func _on_animation_finished() -> void:
	if animations.animation == "die":
		animation_done = true
		check_delete()


## handle death sound finishing
func _on_death_sound_finished() -> void:
	sound_done = true
	check_delete()
	

## if the death animation and the death sound are finished, delete the enemy
## alternatively, if the death animation is finished and there's no death sound for whatever reason
func check_delete() -> void:
	if animation_done and sound_done:
		path_movement.path.queue_free()
	elif animation_done and not is_instance_valid(death_sound.stream):
		path_movement.path.queue_free()
