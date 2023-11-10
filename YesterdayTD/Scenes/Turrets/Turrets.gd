extends Node2D

var type
var category
var enemy_array = []
var built = false
var enemy
var loaded = true

func _ready():
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[type]["range"]

func _physics_process(delta): ## if there is an enemy to track, do so
	if enemy_array.size() != 0 and built:
		select_enemy()
		if not get_node("AnimationPlayer").is_playing():
			turn()
		if loaded:
			fire()
	else:
		enemy = null
	
func turn(): ## turrets look at mouse
	get_node("Turret").look_at(enemy.position)

func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.progress) ## tracks distance enemy has traveled
	var max_offset = enemy_progress_array.max() ## prioritize enemy with most distance
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]

func fire():
	loaded = false
	if category == "projectile":
		fire_gun()
	elif category == "missile":
		fire_missiles()
	enemy.on_hit(GameData.tower_data[type]["damage"])
	await get_tree().create_timer(GameData.tower_data[type]["rof"]).timeout
	loaded = true

func fire_gun():
	get_node("AnimationPlayer").play("Fire")

func fire_missiles():
	pass

func _on_range_body_entered(body): ## turret adds enemy to list
	enemy_array.append(body.get_parent())
	print(enemy_array)

func _on_range_body_exited(body): ## turret removes enemy from list
	enemy_array.erase(body.get_parent())
