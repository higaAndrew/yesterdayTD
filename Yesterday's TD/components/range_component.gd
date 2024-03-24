class_name RangeComponent
extends Area2D

signal body_target_entered(target: Node2D)
signal body_target_exited(target: Node2D)
signal area_target_entered(target: Area2D)
signal area_target_exited(target: Area2D)

# range component requires a CollisionShape2D to function
@onready var detection_range: CollisionShape2D = get_child(0)


func _on_body_entered(body: Node2D) -> void:
	# if collision with Node2D
	body_target_entered.emit(body)


func _on_body_exited(body: Node2D) -> void:
	# if collision with Node2D ended
	body_target_exited.emit(body)


func _on_area_entered(area: Area2D) -> void:
	# if collision with Area2D
	area_target_entered.emit(area)


func _on_area_exited(area: Area2D) -> void:
	# if collision with Area2D ended
	area_target_exited.emit(area)
