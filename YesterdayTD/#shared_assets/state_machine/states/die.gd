class_name Die
extends State

## TODO die state
signal died


func enter() -> void:
	died.emit()
