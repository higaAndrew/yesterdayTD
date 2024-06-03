extends Node


## simple signal verification and connection
## ex: GlobalScripts.connect_signal(parent, "signal_x", self, "on_signal_x")
func connect_signal(emitter: Node, signal_name: String, target: Object, method: String) -> void:
	if emitter.has_signal(signal_name):
		emitter.connect(signal_name, Callable(target, method))
	else:
		printerr("%s is missing %s signal!" %[emitter.name, signal_name])
		return


## simple instance verification
## ex: GlobalScripts.verify(self, component_x, "component_x")
func verify(emitter: Node, instance: Object, instance_name: String) -> void:
	if not is_instance_valid(instance):
		printerr("%s is missing %s component!" %[emitter.name, instance_name])
		return
