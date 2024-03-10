extends Area2D

var _towers_to_build := {
	"gatling": preload("res://entities/towers/gatling_tower.tscn"),
	"cannon": preload("res://entities/towers/cannon_tower.tscn"),
	"missile": preload("res://entities/towers/cannon_tower.tscn"),
}

var tower: Tower

@onready var tower_popup := $UI/TowerPopup as CanvasLayer


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and \
			event.button_index == MOUSE_BUTTON_LEFT and not tower:
		tower_popup.show()


func _on_tower_popup_tower_requested(type) -> void:
	tower = _towers_to_build[type].instantiate()
	add_child(tower, true)
	tower_popup.hide()
	tower.tower_destroyed.connect(_on_tower_destroyed)


func _on_tower_destroyed():
	tower = null
