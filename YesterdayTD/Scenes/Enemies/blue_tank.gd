extends PathFollow2D

var speed = 150
var hp = 50

@onready var health_bar = get_node("HealthBar")
@onready var impact_area = get_node("Impact")
var projectile_impact = preload("res://Scenes/SupportScenes/projectile_impact.tscn")

func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_top_level(true)

func _physics_process(delta): ## move every tick
	move(delta)

func move(delta): ## move along the path
	set_progress(get_progress() + speed * delta)
	health_bar.position = position - Vector2(30, 30) ## health bar doesn't rotate

func on_hit(damage):
	impact()
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()

func impact(): ## randomize position of impact
	randomize()
	var x_pos = randi() % 31
	randomize()
	var y_pos = randi() % 31
	var impact_location = Vector2(x_pos, y_pos)
	var new_impact = projectile_impact.instantiate()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)

func on_destroy():
	get_node("CharacterBody2D").queue_free()
	await get_tree().create_timer(0.2).timeout
	self.queue_free()
