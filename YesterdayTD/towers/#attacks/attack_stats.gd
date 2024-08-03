class_name AttackStats
extends Resource


## TODO Tiered upgrades
@export_group("Basic Attacks")
@export var base_damage: float = 0.0
@export var base_pierce: int = 0
@export var base_attack_cooldown: float = 1.0
@export var base_size: float = 1.0

@export_group("Projectiles")
@export var base_speed: float = 0.0
@export var base_lifespan: float = 0.0

@export_group("Attack Interactions")
@export var inherits_interactions: bool = true
@export var can_hit_flying: bool = false

@export_group("Misc.")
@export var base_pierce_cooldown: float = 0.0
