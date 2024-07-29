extends Node
## this autoload script holds all of the money information/functions for the current map


signal coins_changed()

var current_coins: int


## set the starting coin value to a given amount
func set_coins(amount: int) -> void:
	current_coins = amount
	coins_changed.emit()


## increase the current game's coins by a given amount
func increase_coins(amount: int) -> void:
	current_coins += amount
	coins_changed.emit()


## decrease the current game's coins by a given amount
func decrease_coins(amount: int) -> void:
	var remainder: int = current_coins - amount
	if remainder < 0:
		printerr("Could not decrease coins from %s to %s." % [current_coins, remainder])
		return
	else:
		current_coins -= amount
		coins_changed.emit()


## returns a formatted string of current coins
func get_current_coins() -> String:
	return GlobalScripts.format_number(current_coins)
