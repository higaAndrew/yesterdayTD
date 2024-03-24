class_name Spawner
extends Node2D

@onready var map := $"../" as Node2D
@onready var path := $"../Path2D" as Path2D
@onready var wave_timer := $WaveTimer as Timer
@onready var group_timer := $GroupTimer as Timer
@onready var spawn_timer := $SpawnTimer as Timer

var enemies := {
	"piston": preload("res://entities/enemies/robots/piston.tscn"),
	"rivet": preload("res://entities/enemies/robots/rivet.tscn"),
	"cog": preload("res://entities/enemies/robots/cog.tscn"),
}
var waves := []
var wave := []
var current_wave := 0
var wave_count := 0
var groups := []
var group := {}
var current_group := 0
var group_count := 0
var enemy_iter := 0
var enemy_type := ""
var enemy_count := 0
var spawn_delay := 0.0
var group_delay := 0.0
var wave_delay := 10
var z_level := 0


func _ready() -> void:
	# wait for map to be ready, fetch waves data, and start WaveTimer
	await owner.ready
	waves = map.waves
	wave_count = waves.size()
	wave_timer.start()

# i really REALLY wish i could have used for loops for this it would have made it so much easier for me
func _on_wave_timer_timeout() -> void:
	# when WaveTimer ends, fetch specific wave data, and start GroupTimer
	if current_wave < wave_count:
		wave = waves[current_wave]
		group_count = wave.size()
		group_timer.start()
	# no more waves
	elif current_wave == wave_count:
		print("No more waves!")


func _on_group_timer_timeout() -> void:
	# when GroupTimer ends, fetch group data, and start SpawnTimer
	if current_group < group_count:
		group = wave[current_group]
		enemy_type = group["enemy_type"]
		enemy_count = group["enemy_count"]
		spawn_delay = group["spawn_delay"]
		group_delay = group["group_delay"]
		spawn_timer.start()
	# if the last group has been reached, reset the group count and proceed to the next wave
	elif current_group == group_count:
		current_group = 0
		current_wave += 1
		z_level = 0
		wave_timer.set_wait_time(wave_delay)
		wave_timer.start()
		print("next wave!")


func _on_spawn_timer_timeout() -> void:
	# when SpawnTimer ends, spawn the enemy on the path, and set up the next SpawnTimer
	if enemy_iter < enemy_count:
		spawn_timer.set_wait_time(spawn_delay)
		if spawn_delay == 0.0:
			spawn_timer.set_wait_time(1)
		print(enemy_iter)
		var enemy: PathFollow2D = enemies[enemy_type].instantiate()
		path.add_child(enemy)

		# to prevent z-fighting
		enemy.z_index = z_level
		z_level += 1

		enemy_iter += 1
		spawn_timer.start()
		print("next enemy!")
	# if the last enemy has been spawned, reset the spawn count and proceed to the next group
	elif enemy_iter == enemy_count:
		enemy_iter = 0
		current_group += 1
		group_timer.set_wait_time(group_delay)
		group_timer.start()
		print("next group!")
