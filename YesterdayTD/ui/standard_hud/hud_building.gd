extends State

var tower_builder: TowerBuilderComponent

func init() -> void:
	tower_builder = parent.tower_builder


func loop() -> void:
	tower_builder.set_tower_preview()


func physics_process(delta: float) -> void:
	tower_builder.update_tower_preview()
