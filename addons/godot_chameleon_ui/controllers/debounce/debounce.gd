class_name Debounce
extends Node

@export var delay_time: float = 0.5

var _debounce_timer: SceneTreeTimer


func debounce(callable: Callable, delay: float = delay_time) -> void:
	if _debounce_timer:
		var connections = _debounce_timer.timeout.get_connections()
		for connection in connections:
			_debounce_timer.timeout.disconnect(connection.callable)
	_debounce_timer = get_tree().create_timer(delay)
	_debounce_timer.timeout.connect(callable)
