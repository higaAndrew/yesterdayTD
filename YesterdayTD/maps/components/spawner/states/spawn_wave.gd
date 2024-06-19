extends State

var wave_timer: Timer
var spawning: SpawningComponent


## setup timer and wave count
func init() -> void:
	wave_timer = parent.wave_timer
	GlobalScripts.connect_signal(wave_timer, "timeout", self, "_on_wave_timer_timeout")
	
	spawning = parent.spawning


## every loop, start the wave timer
func loop() -> void:
	wave_timer.set_wait_time(parent.wave_delay)
	wave_timer.start()


## when the wave timer finishes, prepare the next group
func _on_wave_timer_timeout() -> void:
	if not current_state():
		return
	
	if spawning.current_wave < spawning.wave_count:
		transitioned.emit(self, "SpawnGroup")
	else:
		transitioned.emit(self, "SpawnerIdle")
