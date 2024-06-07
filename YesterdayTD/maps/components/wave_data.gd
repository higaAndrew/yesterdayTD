class_name WaveData
extends Node

## generic wave data class just so i can call for it specifically from the editor
## debug waves are preset
var debug_waves := [
	[	# wave 1
		{"enemy_type": "piston", "enemy_count": 5, "spawn_delay": 0.5, "group_delay": 2.0},
		{"enemy_type": "rivet", "enemy_count": 10, "spawn_delay": 0.25, "group_delay": 5.0},
		{"enemy_type": "piston", "enemy_count": 7, "spawn_delay": 0.1, "group_delay": 0.1},
	], [	# wave 2
		{"enemy_type": "piston", "enemy_count": 30, "spawn_delay": 0.01, "group_delay": 0.001},
		{"enemy_type": "piston", "enemy_count": 30, "spawn_delay": 0.05, "group_delay": 0.0},
	],
]
var story_waves := [[{}]]
var standard_waves := [[{}]]
var x2_waves := [[{}]]
var x10_waves := [[{}]]
var extraction_waves := [[{}]]
var eggs_waves := [[{}]]

