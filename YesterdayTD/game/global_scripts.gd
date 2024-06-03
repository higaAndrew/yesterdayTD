extends Node

func connect_signal(emitter: Node, signal_name: String, target: Object, method: String) -> void:
	if emitter.has_signal(signal_name):
		emitter.connect(signal_name, Callable(target, method))
	else:
		printerr("%s is missing %s signal!" %[emitter.name, signal_name])
		return

func verify(emitter: Node, instance: Object, instance_name: String) -> void:
	if not is_instance_valid(instance):
		printerr("%s is missing %s(%s)!" %[emitter.name, instance_name, str(typeof(instance))])
		return
