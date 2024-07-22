class_name TowerBuilderComponent
extends Node
##TODO descriptions

@export var build_sound: AudioStreamPlayer

## preload every enemy
@export var towers: Dictionary = {
	"snowballer": preload("res://towers/snowballer/snowballer.tscn"),
	"snowbomber": preload("res://towers/snowbomber/snowbomber.tscn"),
	"debug_tower": preload("res://#debug/debug_tower.tscn"),
}

## variables from parent
var parent: Control
var hud: CanvasLayer
var current_tower: PackedScene
var mouse_position: Vector2
var tower_preview: Area2D
var valid_location: bool = false

var canvas: Node
var path: Path2D
var tower_layer: CanvasLayer


## set spawner values according to stats
func init(_parent: Control) -> void:
	parent = _parent
	hud = parent.hud
	path = find_parent("Canvas").find_child("GroundEnemyPath")
	tower_layer = find_parent("Canvas").find_child("Towers")


func set_current_tower(tower_name: String) -> void:
	match tower_name.to_lower():
		"debugtower":
			current_tower = towers["debug_tower"]
		_:
			current_tower = towers[tower_name.to_lower()]


func set_build_preview() -> void:
	mouse_position = get_viewport().get_mouse_position()
	tower_preview = current_tower.instantiate()
	hud.add_child(tower_preview)
	tower_preview.global_position = mouse_position
	## FIXME doesn't work
	tower_preview.set_physics_process(false)
	tower_preview.detection_range.set_visible(true)


func update_build_preview() -> void:
	## allow offset dragging?
	mouse_position = get_viewport().get_mouse_position()
	tower_preview.global_position = mouse_position
	
	if mouse_position.distance_to(path.curve.get_closest_point(mouse_position)) < 65.0:
		valid_location = false
		tower_preview.set_modulate(Color.RED)
	else:
		valid_location = true
		tower_preview.set_modulate(Color.WHITE)


func build_tower() -> void:
	tower_preview.reparent(tower_layer)
	## FIXME doesn't work
	tower_preview.set_physics_process(true)
	tower_preview = null


func cancel_build() -> void:
	valid_location = false
	tower_preview.queue_free()
