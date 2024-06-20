extends State


var group_timer: Timer
var spawning: SpawningComponent


## setup group timer and spawning component
func init() -> void:
	spawning = parent.spawning
	
	group_timer = parent.group_timer
	GlobalScripts.connect_signal(group_timer, "timeout", self, "_on_group_timer_timeout")


## every loop, prepare the upcoming wave and start the timer
func loop() -> void:
	spawning.prepare_wave()
	group_timer.start()


## prepare to spawn next group
## if there's no more groups, move to next wave
func _on_group_timer_timeout() -> void:
	if not current_state():
		return
	
	if spawning.current_group < spawning.group_count:
		transitioned.emit(self, "SpawnEnemy")
	elif spawning.current_group == spawning.group_count:
		spawning.next_wave()
		transitioned.emit(self, "SpawnWave")
