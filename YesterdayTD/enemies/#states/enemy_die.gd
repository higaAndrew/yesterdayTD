extends State


var hitbox: Hitbox
var animations: AnimatedSprite2D
var death_sound: AudioStreamPlayer
var health: HealthComponent
var layers: LayersComponent
var path_movement: PathMovementComponent

var animation_done: bool = false
var sound_done: bool = false


## get parent's components
func enter() -> void:
	hitbox = parent.hitbox
	health = parent.health
	path_movement = parent.path_movement
	
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	death_sound = parent.death_sound
	GlobalScripts.connect_signal(death_sound, "finished", self, "_on_death_sound_finished")
	
	## if the enemy has children, spawn them
	if not parent.stats.children.is_empty():
		layers = parent.layers
		layers.spawn_children()
	
	GlobalScripts.play_animation(parent, animations, "die")
	hitbox.remove_hitbox()
	health.play_death_sound()


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
		delete()
	
	elif animation_done and not is_instance_valid(death_sound.stream):
		delete()


## remove the enemy from the list of remaining enemies, and delete the parent's pathfollow2d
func delete() -> void:
	path_movement.delete()
