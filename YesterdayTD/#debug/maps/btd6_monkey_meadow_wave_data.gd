extends WaveData


func _ready() -> void:
	debug_waves = [
		[	# wave 1
			#{"enemy_type": "hammer", "enemy_count": 10, "spawn_delay": 1, "group_delay": 2},
			#["piston", 10, 0.5, 1],
			#["rivet", 10, 0.5, 1],
			#["cog", 10, 0.5, 1],
			#["hammer", 10, 2, 5],
			["anvil", 10, 3, 5],
		],
		[
			["piston", 30, 0.1, 3],
		]
	]
	pass
