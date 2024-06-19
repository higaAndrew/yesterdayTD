extends WaveData

func _ready() -> void:
	debug_waves = [
		[	# wave 1
			#{"enemy_type": "hammer", "enemy_count": 10, "spawn_delay": 1, "group_delay": 2},
			["hammer", 10, 1, 10],
		],
		[
			["cog", 20, 0.5, 3],
		]
	]
	pass
