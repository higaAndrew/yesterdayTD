extends State


var group_timer: Timer
var spawn_timer: Timer
var spawning: SpawningComponent


## setup spawn timer and spawning component
func init() -> void:
	group_timer = parent.group_timer
	spawning = parent.spawning
	
	spawn_timer = parent.spawn_timer
	GlobalScripts.connect_signal(spawn_timer, "timeout", self, "_on_spawn_timer_timeout")


## every loop, prepare the upcoming wave and start the timer
func loop() -> void:
	spawning.prepare_group()
	
	# the first enemy will not have a timer value, so skip the timer
	if spawning.enemy_zero:
		spawning.enemy_zero = false
		_on_spawn_timer_timeout()
	else:
		spawn_timer.start()


## spawn the enemy, and either transition back to self
## or finish the group and move to the next
func _on_spawn_timer_timeout() -> void:
	if not current_state():
		return
	
	if spawning.current_enemy < spawning.enemy_count:
		# ensure the enemy type is valid and spawn it
		spawning.verify_enemy()
		spawning.spawn_enemy()
		
		# prepare to spawn the next one, setting up timer delays
		if spawning.spawn_delay <= 0.0:
			spawning.enemy_zero = true
		else:
			spawn_timer.set_wait_time(spawning.spawn_delay)
		
		transitioned.emit(self, "SpawnEnemy")
	
	# if there's no more enemies in the group, move on to the next
	elif spawning.current_enemy == spawning.enemy_count:
		spawning.next_group()
		
		# the debugger gets pissy if the timer is set to 0
		if spawning.group_delay <= 0.0:
			spawning.group_zero = true
		else:
			group_timer.set_wait_time(spawning.group_delay)
		
		transitioned.emit(self, "SpawnGroup")
