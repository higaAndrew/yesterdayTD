class_name CoinValueComponent
extends Node


var parent: Area2D
var base_coin_value: int
var current_coin_value: int


## set health values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_coin_value = parent.stats.base_coin_value
	current_coin_value = base_coin_value


## increase coin value
func increase_coin_value(amount: int) -> void:
	current_coin_value += amount


## decrease coin value
func decrease_coin_value(amount: int) -> void:
	current_coin_value -= amount


## reset coin value
func reset_coin_value() -> void:
	current_coin_value = base_coin_value


## multiply coin value
func multiply_coin_value(amount: float) -> void:
	current_coin_value = int(float(current_coin_value) * (1.0 + amount))


## increase current game's coin count
func gain_coins() -> void:
	MoneyManager.gain_coins(current_coin_value)


## decrease current game's coin count
func lose_coins() -> void:
	MoneyManager.spend_coins(current_coin_value)
