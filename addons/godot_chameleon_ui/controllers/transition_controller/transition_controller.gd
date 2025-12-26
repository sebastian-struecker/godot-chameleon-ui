# reference: https://www.youtube.com/watch?v=2nv49zosKIY&list=PLEHvj4yeNfeGiG6ZJXDymk5dYBAjCGiwe&index=4
@tool
class_name TransitionController
extends Control

signal animation_finished

const FADE_IN: String = "Fade In"
const FADE_OUT: String = "Fade Out"

@export var background_color: Color = Color.BLACK:
	set(value):
		background_color = value
		if background_color_rect:
			background_color_rect.color = background_color
@export_range(0, 1, 0.001) var alpha: float = 0:
	set(value):
		alpha = value
		if background_color_rect:
			background_color_rect.color.a = value

@onready var background_color_rect: ColorRect = $BackgroundColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	alpha = 0
	_connect_signals()


func transition_in(seconds: float) -> void:
	_transition(FADE_IN, seconds)


func transition_out(seconds: float) -> void:
	_transition(FADE_OUT, seconds)


func _get_configuration_warnings():
	if !background_color_rect:
		return ["Component must be added through %'Instantiate child scene%'"]
	return []


func _transition(animation: String, seconds: float) -> void:
	if animation_player:
		animation_player.play(animation, -1.0, 1 / seconds)


func _connect_signals() -> void:
	if animation_player:
		animation_player.animation_finished.connect(_on_animation_player_animation_finished)


func _on_animation_player_animation_finished(_name: String) -> void:
	animation_finished.emit()
