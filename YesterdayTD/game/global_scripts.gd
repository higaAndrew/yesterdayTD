extends Node


## simple signal verification and connection
## ex: GlobalScripts.connect_signal(parent, "signal_x", self, "on_signal_x")
func connect_signal(emitter: Node, signal_name: String, target: Object, method: String) -> void:
	if emitter.has_signal(signal_name):
		emitter.connect(signal_name, Callable(target, method))
	else:
		printerr("%s is missing %s signal!" % [emitter.name, signal_name])
		return


## simple instance verification, used for export variables
## ex: GlobalScripts.verify(self, component_x, "component_x")
func verify(emitter: Node, instance: Object, instance_name: String) -> void:
	if not is_instance_valid(instance):
		printerr("%s is missing (or did not link) %s component!" % [emitter.name, instance_name])
		return


## ensure an animation exists for an animated sprite
## ex: GlobalScripts.play_animation(parent, animations, "animation_x")
func play_animation(emitter: Node, animated_sprite: AnimatedSprite2D, animation_name: String) -> void:
	animated_sprite.play(animation_name)
	
	if animated_sprite.animation != animation_name:
		printerr("%s has no animation called %s!" % [emitter.name, animation_name])
		return
