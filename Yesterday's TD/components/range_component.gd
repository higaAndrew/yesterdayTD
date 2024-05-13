class_name RangeComponent
extends Area2D

signal body_target_entered(target: Node2D)
signal body_target_exited(target: Node2D)
signal area_target_entered(target: Area2D)
signal area_target_exited(target: Area2D)

# range component requires a CollisionShape2D to function
@onready var detection_range: CollisionShape2D = get_child(0)


# if collision with Node2D
func _on_body_entered(body: Node2D) -> void:
	body_target_entered.emit(body)


# if collision with Node2D ended
func _on_body_exited(body: Node2D) -> void:
	body_target_exited.emit(body)


# if collision with Area2D
func _on_area_entered(area: Area2D) -> void:
	area_target_entered.emit(area)


# if collision with Area2D ended
func _on_area_exited(area: Area2D) -> void:
	area_target_exited.emit(area)
