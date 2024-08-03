class_name Shadow
extends Sprite2D


@export var sprite: CanvasGroup
@export var shadow_offset: Vector2


func _ready() -> void:
	self.texture = CanvasTexture.new()
	self.texture.viewport_path = sprite.get_path()
