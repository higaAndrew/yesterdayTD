extends Node


@onready var robot_death := %RobotDeath as Node
var robot_death_sounds: Array = []
@onready var robot_hurt := %RobotHurt as Node
var robot_hurt_sounds: Array = []

@onready var vehicle_death := %VehicleDeath as Node
var vehicle_death_sounds: Array = []
@onready var vehicle_hurt := %VehicleHurt as Node
var vehicle_hurt_sounds: Array = []

@onready var objective_death := %ObjectiveDeath as Node
var objective_death_sounds: Array = []
@onready var objective_hurt := %ObjectiveHurt as Node
var objective_hurt_sounds: Array = []

@onready var tower_build := %TowerBuild as Node
var tower_build_sounds: Array = []

@onready var snowbomb_explosion := %SnowbombExplosion as Node
var snowbomb_explosion_sounds: Array = []


## initialize sounds
func _ready() -> void:
	init_sounds(robot_death, robot_death_sounds)
	init_sounds(robot_hurt, robot_hurt_sounds)
	
	init_sounds(vehicle_death, vehicle_death_sounds)
	init_sounds(vehicle_hurt, vehicle_hurt_sounds)
	
	init_sounds(objective_death, objective_death_sounds)
	init_sounds(objective_hurt, objective_hurt_sounds)
	
	init_sounds(tower_build, tower_build_sounds)
	
	init_sounds(snowbomb_explosion, snowbomb_explosion_sounds)


## check to see if any sound categories are empty
## if not, then initialize them
func init_sounds(sound_node: Node, sound_list: Array) -> void:
	if sound_node.get_child_count() == 0:
		printerr("There are no %s sounds!" % sound_node.name)
		return
	
	for child in sound_node.get_children():
		if child is AudioStreamPlayer:
			sound_list.append(child)


## play a sound without modifications
func play_sound(sound_list_name: String) -> void:
	var sound_list: Array = self.get(sound_list_name)
	
	if sound_list.size() == 0:
		return
	
	var rng: int = randi_range(0, (sound_list.size() - 1))
	var sound: AudioStreamPlayer = sound_list[rng]
	
	if is_instance_valid(sound.get_parent().find_child("Timer")):
		var timer = sound.get_parent().find_child("Timer")
		if timer.is_stopped():
			sound.play()
			timer.start()
			timer = null
	else:
		sound.play()


## play a sound with a variable pitch
func play_sound_random_pitch(sound_list_name: String) -> void:
	var sound_list: Array = self.get(sound_list_name)
	
	if sound_list.size() == 0:
		return
	
	var rng: int = randi_range(0, (sound_list.size() - 1))
	var sound: AudioStreamPlayer = sound_list[rng]
	sound.set_pitch_scale(randf_range(0.8, 1.2))
	
	if is_instance_valid(sound.get_parent().find_child("Timer")):
		var timer = sound.get_parent().find_child("Timer")
		if timer.is_stopped():
			sound.play()
			timer.start()
		else:
			return
	else:
		sound.play()
