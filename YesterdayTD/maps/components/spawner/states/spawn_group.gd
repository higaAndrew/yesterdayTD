extends State

## so i don't have to type parent 50 times
var p: Node2D


## setup group timer
func init() -> void:
	p = parent
	GlobalScripts.connect_signal(p.group_timer, "timeout", self, "_on_group_timer_timeout")


## every loop, extract the number of groups and start the group timer
func loop() -> void:
	p.group_count = p.wave.size()
	p.group_timer.start()


## prepare to spawn next group
## if there's no more groups, move to next wave
func _on_group_timer_timeout() -> void:
	if not current_state():
		return
	
	if p.current_group < p.group_count:
		p.group = p.wave[p.current_group]
		transition.emit(self, "SpawnEnemy")
	elif p.current_group == p.group_count:
		p.current_group = 0
		p.current_wave += 1
		transition.emit(self, "SpawnWave")
