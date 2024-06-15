extends State

## blah blah parent you get it
var p: Node2D

## preload every enemy
## HACK change to parent preload?
var enemies := {
	"piston": preload("res://enemies/ground/piston/piston.tscn"),
	"rivet": preload("res://enemies/ground/rivet/rivet.tscn"),
	"cog": preload("res://enemies/ground/cog/cog.tscn"),
}

var enemy: PathFollow2D
var path: Path2D


## setup spawn timer
func init() -> void:
	p = parent
	GlobalScripts.connect_signal(p.spawn_timer, "timeout", self, "_on_spawn_timer_timeout")


## every loop, extract the group details, and start the timer
func loop() -> void:
	p.enemy_type = p.group["enemy_type"]
	p.enemy_count = p.group["enemy_count"]
	p.spawn_delay = p.group["spawn_delay"]
	p.group_delay = p.group["group_delay"]
	p.spawn_timer.start()


## spawn the enemy, and either transition back to self
## or finish the group and move to the next
func _on_spawn_timer_timeout() -> void:
	if not current_state():
		return
	
	# ensure the enemy type is valid
	if p.current_enemy < p.enemy_count:
		if p.enemy_type not in enemies:
			printerr("The enemy type %s does not exist!" % p.enemy_type)
			return
		
		# spawn it
		enemy = enemies[p.enemy_type].instantiate()
		assign_path(enemy)
		p.current_enemy += 1
		
		# prepare to spawn the next one, setting up timer delays
		if p.spawn_delay <= 0.0:
			p.spawn_timer.set_wait_time(1.0)
		else:
			p.spawn_timer.set_wait_time(p.spawn_delay)
		
		transition.emit(self, "SpawnEnemy")
	
	# if there's no more enemies in the group, move on to the next
	elif p.current_enemy == p.enemy_count:
		p.current_enemy = 0
		p.current_group += 1
		
		# the debugger gets pissy if the timer is set to 0
		if p.group_delay == 0:
			p.group_delay = 0.001
			
		p.group_timer.set_wait_time(p.group_delay)
		transition.emit(self, "SpawnGroup")


## determine the path that the enemy is spawned on
## HACK might want to redo
func assign_path(_enemy: PathFollow2D) -> void:
	if _enemy.is_in_group("ground_enemies"):
		path = p.ground_enemies
	elif _enemy.is_in_group("ground_vehicles"):
		path = p.ground_vehicles
	elif _enemy.is_in_group("ground_bosses"):
		path = p.ground_bosses
	elif _enemy.is_in_group("air_enemies"):
		path = p.air_enemies
	elif _enemy.is_in_group("air_vehicles"):
		path = p.air_vehicles
	elif _enemy.is_in_group("air_bosses"):
		path = p.air_bosses
	else:
		printerr("%s is not in an enemy group!" % _enemy.name)
	path.add_child(_enemy)
