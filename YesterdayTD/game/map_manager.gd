extends Node
## this autoload script holds all of the information for the current game/map
##TODO desc


## TOWERS AND TOWER STATS
var tower_stats_list: Dictionary = {
	"snowballer": preload("res://towers/snowballer/snowballer_stats.tres"),
	"snowbomber": preload("res://towers/snowbomber/snowbomber_stats.tres"),
	"debug_tower": preload("res://#debug/debug_tower_stats.tres"),
}
