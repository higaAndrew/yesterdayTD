extends Node


## simple signal verification and connection
## ex: GlobalScripts.connect_signal(parent, "signal_x", self, "on_signal_x")
func connect_signal(emitter: Node, signal_name: String, target: Object, method: String) -> void:
	if emitter.has_signal(signal_name):
		emitter.connect(signal_name, Callable(target, method))
	else:
		printerr("%s is missing %s signal!" % [emitter.name, signal_name])
		return


## signal verification and connection
## with added object parameter
func connect_signal_object(emitter: Node, signal_name: String, target: Object, method: String, object: Object) -> void:
	if emitter.has_signal(signal_name):
		var callable = Callable(target, method).bind(object)
		emitter.connect(signal_name, callable)
	else:
		printerr("%s is missing %s signal!" % [emitter.name, signal_name])
		return


## signal verification and connection
## with added variant parameter
func connect_signal_variant(emitter: Node, signal_name: String, target: Object, method: String, variant: Variant) -> void:
	if emitter.has_signal(signal_name):
		var callable = Callable(target, method).bind(variant)
		emitter.connect(signal_name, callable)
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


## format a given number into a string with commas designating thousands intervals
## i was too lazy to write it myself so I got it from GPT
## but it sucked and i had to fix it so much that i pretty much wrote it myself anyways
func format_number(number: float) -> String:
	var integer_part: int
	var float_part: float
	var integer_string: String
	var pre_decimal_part: String
	var post_decimal_part: String
	
	integer_part = abs(int(number))
	integer_string = str(integer_part)
	float_part = abs(number) - integer_part
	
	while integer_string.length() > 3:
		pre_decimal_part = "," + integer_string.substr(integer_string.length() - 3, 3) + pre_decimal_part
		integer_string = integer_string.substr(0, integer_string.length() - 3)
	
	pre_decimal_part = integer_string + pre_decimal_part
	
	if float_part == 0.0:
		post_decimal_part = ""
	else:
		post_decimal_part = str(float_part).substr(1)
	
	if number < 0.0:
		return "-" + pre_decimal_part + post_decimal_part
	else:
		return pre_decimal_part + post_decimal_part
