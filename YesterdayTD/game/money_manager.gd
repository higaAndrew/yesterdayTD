extends Node
## this autoload script holds all of the money information/functions for the current map


signal coin_count_changed()

var current_coin_count: int


## set the starting coin value to a given amount
func set_coin_count(amount: int) -> void:
	current_coin_count = amount
	coin_count_changed.emit()


## increase the current game's coin count by a given amount
func gain_coins(amount: int) -> void:
	current_coin_count += amount
	coin_count_changed.emit()


## decrease the current game's coin count by a given amount
func spend_coins(amount: int) -> void:
	var remainder: int = current_coin_count - amount
	if remainder < 0:
		printerr("Could not decrease coin count from %s to %s." % [current_coin_count, remainder])
		return
	else:
		current_coin_count -= amount
		coin_count_changed.emit()


## returns a formatted string of the current coin count
func get_current_coin_count() -> String:
	return GlobalScripts.format_number(current_coin_count)
