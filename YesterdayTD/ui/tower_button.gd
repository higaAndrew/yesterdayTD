class_name TowerButton
extends Button


@export var tower_name: String = "debug_tower"

var stats: TowerStats
var price: int


## render the button's image and text
func _ready() -> void:
	get_tower_stats()
	init_price()
	
	GlobalScripts.connect_signal(MoneyManager, "coins_changed", self, "_on_coins_changed")


## based on the tower name, fetch the stats from autoload
func get_tower_stats() -> void:
	if tower_name in TowerManager.tower_stats_list:
		stats = TowerManager.tower_stats_list[tower_name]
	else:
		printerr("%s is either not a valid tower name, or is not in the tower list in TowerManager" % tower_name)
		return


## get the price value from the stats and display it
func init_price() -> void:
	price = stats.base_price
	self.text = GlobalScripts.format_number(price)


## when the money amount changes, change the status of the button
func _on_coins_changed() -> void:
	if MoneyManager.current_coins < price:
		self.set_disabled(true)
	elif self.disabled:
		self.set_disabled(false)
