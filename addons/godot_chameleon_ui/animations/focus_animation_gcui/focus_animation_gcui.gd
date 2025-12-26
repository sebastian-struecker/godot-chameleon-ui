# created from: https://www.youtube.com/watch?v=jF3UgstQ1Yk
# could be further developed with: https://www.youtube.com/watch?v=3lJqkn6nD0o
class_name FocusAnimationGCUI
extends Node

@export var control: Control
@export var use_tweens: bool = true
@export var is_anchor_center: bool = true
@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var time: float = 0.1
@export var transition_type: Tween.TransitionType = Tween.TransitionType.TRANS_SPRING
@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_IN_OUT

var default_scale: Vector2


func _init() -> void:
	call_deferred("setup")


func setup() -> void:
	if !control:
		return
	connect_signals()
	if is_anchor_center:
		control.pivot_offset = control.size / 2
	default_scale = control.scale
	_check_focus()


func connect_signals() -> void:
	if !control.resized.has_connections():
		control.resized.connect(setup)
	if control.focus_mode == control.FOCUS_ALL:
		if !control.mouse_entered.is_connected(_grab_focus):
			control.mouse_entered.connect(_grab_focus)
		#control.mouse_exited.connect(control.release_focus)
		if !control.focus_entered.is_connected(_check_focus):
			control.focus_entered.connect(_check_focus)
		if !control.focus_exited.is_connected(_check_focus):
			control.focus_exited.connect(_check_focus)


func _grab_focus() -> void:
	control.grab_focus()


func _check_focus() -> void:
	if control.has_focus():
		if use_tweens:
			_add_tween("scale", hover_scale, time)
		else:
			control.scale = hover_scale
	else:
		if use_tweens:
			_add_tween("scale", default_scale, time)
		else:
			control.scale = default_scale


func _add_tween(property: String, value, tween_time: float) -> void:
	if !is_inside_tree():
		return
	if get_tree() == null:
		return
	var tween = get_tree().create_tween()
	tween.tween_property(control, property, value, tween_time).set_trans(transition_type).set_ease(ease_type)
	tween.bind_node(self)
