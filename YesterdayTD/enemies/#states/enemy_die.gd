extends State


var hitbox: Hitbox
var animations: AnimatedSprite2D
var coin_value: CoinValueComponent
var health: HealthComponent
var layers: LayersComponent
var path_movement: PathMovementComponent
var sound: SoundComponent


## get parent's components
func enter() -> void:
	hitbox = parent.hitbox
	coin_value = parent.coin_value
	health = parent.health
	path_movement = parent.path_movement
	sound = parent.sound
	
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	## if the enemy has children, spawn them
	if not parent.stats.children.is_empty():
		layers = parent.layers
		layers.spawn_children()
	
	coin_value.gain_coins()
	GlobalScripts.play_animation(parent, animations, "die")
	hitbox.remove_hitbox()
	sound.play_death_sound()


## handle death animation finishing
func _on_animation_finished() -> void:
	if animations.animation == "die":
		delete()


## remove the enemy from the list of remaining enemies, and delete the parent's pathfollow2d
func delete() -> void:
	path_movement.delete()
