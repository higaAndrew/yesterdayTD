extends State


var progenitor_attack: Area2D

var hitbox: Hitbox
var health: HealthComponent
var hit_flash: HitFlashComponent
var path_movement: PathMovementComponent
var properties: PropertiesComponent
var sound: SoundComponent

var attack: Area2D


## get parent's components
func enter() -> void:
	progenitor_attack = parent.progenitor_attack
	hitbox = parent.hitbox
	hit_flash = parent.hit_flash
	properties = parent.properties
	sound = parent.sound
	
	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	
	health = parent.health
	GlobalScripts.connect_signal(health, "health_depleted", self, "_on_health_depleted")
	
	path_movement = parent.path_movement
	GlobalScripts.connect_signal(path_movement, "reached_end", self, "_on_reached_end")
	
	# add enemy to list of remaining enemies
	EnemyManager.add_enemy()


## every physics frame, call follow_path method
func physics_process(delta: float) -> void:
	path_movement.follow_path(delta)


## handle attack collisions
func _on_area_entered(area: Area2D) -> void:
	# if this attack spawned the enemy, ignore it
	if area == progenitor_attack:
		return
	
	# if this attack has already hit the enemy, ignore it
	if parent in area.pierce.hit_list:
		return
	
	# if this attack is still on pierce cooldown, ignore it
	if not area.pierce.pierce_active:
		return
	
	# set the current attack for future comparison
	hitbox.current_collision = area
	
	if area is Attack:
		attack = area
		
		# flying enemy handling
		if properties.flying:
			if not attack.attack_interactions.can_hit_flying:
				return
		
		if not attack.pierce.pierce_expended:
			health.take_damage(attack.damage.current_damage)
			sound.play_hurt_sound()
			hit_flash.start_flash()
			# tell the attack that it has hit something
			attack.hitbox.collide()
			attack.hitbox.current_collision = parent
			attack.pierce.hit_list.append(parent)


## handle health reaching 0
func _on_health_depleted() -> void:
	if not current_state():
		return
	
	transitioned.emit(self, "EnemyDie")


## handle reaching the end of the path without colliding with objective
## always active, enemies should never reach the end with no effect
func _on_reached_end() -> void:
	path_movement.delete()
