class_name TowerStats
extends Resource


@export var base_price: int = 100
@export var base_range: float = 100.0
@export_enum("First", "Last", "Strong", "Weak", "Close", "Random") var target_priority: String = "First"

@export_group("Upgrade Paths")
@export_range(0, 3) var base_path_1_tier: int = 0
@export_range(0, 3) var base_path_2_tier: int = 0

@export_group("Attack Interactions")
@export var inherits_interactions: bool = true
@export var can_hit_flying: bool = false
