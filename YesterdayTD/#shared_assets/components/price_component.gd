class_name PriceComponent
extends Node


var parent: Area2D
var base_price: int
var current_price: int
var sell_price: int


## set price values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_price = parent.stats.base_price
	current_price = base_price
	sell_price = int(float(current_price) * 0.75)


## increase price
func increase_price(amount: int) -> void:
	current_price += amount


## decrease price
func decrease_price(amount: int) -> void:
	current_price -= amount


## reset price
func reset_price() -> void:
	current_price = base_price


## multiply price
func multiply_price(amount: float) -> void:
	current_price = int(float(current_price) * (1.0 + amount))


## sell the tower and increase current game's coin count
func sell() -> void:
	MoneyManager.gain_coins(sell_price)


## purchase the tower and decrease current game's coin count
func buy() -> void:
	MoneyManager.spend_coins(current_price)
