class_name CooldownComponent
extends Node


var parent: Area2D
var attacks: Dictionary
var base_attack_cooldown: float
var current_attack_cooldown: float


## set attack speed values according to stats
## room for 4 attacks, can be expanded on
func init(_parent: Area2D) -> void:
	parent = _parent
	
	for i in range(4):
		if ("attack%s_scene" % i) in parent and ("attack%s_stats" % i) in parent:
			var stats: AttackStats = parent.get("attack%s_stats" % i)
			
			base_attack_cooldown = stats.base_attack_cooldown
			current_attack_cooldown = base_attack_cooldown
			
			attacks[i] = {
				"base_attack_cooldown" : base_attack_cooldown,
				"current_attack_cooldown" : current_attack_cooldown,
			}

## retrieve attack cooldown
func get_attack_cooldown(attack_number: int) -> float:
	return attacks[attack_number]["current_attack_cooldown"]


## add attack cooldown
func increase_attack_cooldown(attack_number: int, amount: float) -> void:
	attacks[attack_number]["current_attack_cooldown"] += amount


## subtract attack cooldown
func decrease_attack_cooldown(attack_number: int, amount: float) -> void:
	attacks[attack_number]["current_attack_cooldown"] -= amount


## multiply attack cooldown
func multiply_attack_cooldown(attack_number: int, amount: float) -> void:
	attacks[attack_number]["current_attack_cooldown"] *= amount


## divide attack cooldown
func divide_attack_cooldown(attack_number: int, amount: float) -> void:
	attacks[attack_number]["current_attack_cooldown"] /= amount


## restore attack cooldown to base value
func reset_attack_cooldown(attack_number: int) -> void:
	attacks[attack_number]["current_attack_cooldown"] = attacks[attack_number]["base_attack_cooldown"]
