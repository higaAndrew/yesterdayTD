class_name TowerBuilderComponent
extends Node


@export var build_animation: AnimatedSprite2D
@export var build_sound: AudioStreamPlayer
@export var path_distance: float = 65.0
@export var invalid_range_color: Color = Color(1.0, 0.0, 0.0, 0.15)
@export var invalid_outline_color: Color = Color.RED

## preload every enemy
@export var towers: Dictionary = {
	"snowballer": preload("res://towers/snowballer/snowballer.tscn"),
	"snowbomber": preload("res://towers/snowbomber/snowbomber.tscn"),
	"debug_tower": preload("res://#debug/debug_tower.tscn"),
}

## variables from parent
var parent: Control
var hud: CanvasLayer
var path: Path2D
var tower_layer: CanvasLayer

## local variables
var current_tower: PackedScene
var mouse_position: Vector2
var tower_preview: Area2D
var valid_location: bool = false


## set spawner values according to stats
func init(_parent: Control) -> void:
	parent = _parent
	hud = parent.hud
	path = find_parent("Canvas").find_child("GroundEnemyPath")
	tower_layer = find_parent("Canvas").find_child("Towers")


## change the selected tower to be instantiated
func set_current_tower(tower_name: String) -> void:
	match tower_name.to_lower():
		# tower names longer than one word need to be reformatted
		"debugtower":
			current_tower = towers["debug_tower"]
		# default case
		_:
			current_tower = towers[tower_name.to_lower()]


## instantiate the new tower to be built, preparing its preview variables
func set_build_preview() -> void:
	tower_preview = current_tower.instantiate()
	hud.add_child(tower_preview)
	
	mouse_position = get_viewport().get_mouse_position()
	tower_preview.global_position = mouse_position
	tower_preview.detection_range.set_visible(true)


## as the mouse/preview tower moves, determine whether or not the proposed
## build location is valid or not
func update_build_preview() -> void:
	## HACK allow offset dragging?
	mouse_position = get_viewport().get_mouse_position()
	tower_preview.global_position = mouse_position
	
	# if the tower is too close to the path or is colliding with an obstacle or another tower,
	# invalidate the location for building
	if on_path() or tower_preview.ui.has_obstructions():
		valid_location = false
	elif not on_path() and not tower_preview.ui.has_obstructions():
		valid_location = true
	
	# change the tower's range color depending on the position's validity
	if valid_location:
		tower_preview.range_hitbox.restore_hitbox_color()
		tower_preview.outline.restore_outline_color()
	else:
		tower_preview.range_hitbox.change_hitbox_color(invalid_range_color)
		tower_preview.outline.change_outline_color(invalid_outline_color)


## quick check to see if the tower is overlapping the path
func on_path() -> bool:
	if mouse_position.distance_to(path.curve.get_closest_point(mouse_position)) < path_distance:
		return true
	return false


## plop it down, dissociate with the tower
func build_tower() -> void:
	tower_preview.reparent(tower_layer)
	tower_preview.ui.confirm_build()
	
	##TODO implement place animation better
	build_animation.set_visible(true)
	build_animation.global_position = tower_preview.global_position
	build_animation.play("build")
	
	tower_preview = null


## mercilessly kill the preview tower
func cancel_build() -> void:
	valid_location = false
	tower_preview.queue_free()


## play/verify build sound
func play_build_sound() -> void:
	GlobalScripts.verify(parent, build_sound, "build_sound")
	
	if is_instance_valid(build_sound):
		build_sound.play()
