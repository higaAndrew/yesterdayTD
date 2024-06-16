class_name TowerStats
extends Resource

#@export var base_rotation_speed := 1.0
@export var base_range := 100.0
@export_enum("First", "Last", "Strong", "Weak", "Close", "Random") var target_priority: String = "First"
