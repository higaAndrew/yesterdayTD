extends State

## so i don't have to type parent 50 times
var p: Node2D


## setup timer and wave count
func init() -> void:
	p = parent
	p.wave_count = p.waves.size()
	GlobalScripts.connect_signal(p.wave_timer, "timeout", self, "_on_wave_timer_timeout")


## every loop, start the wave timer
func loop() -> void:
	p.wave_timer.start()


## when the wave timer finishes, prepare the next group
func _on_wave_timer_timeout() -> void:
	if not current_state():
		return
	
	if p.current_wave < p.wave_count:
		p.wave = p.waves[p.current_wave]
		transitioned.emit(self, "SpawnGroup")
	else:
		transitioned.emit(self, "SpawnerIdle")

