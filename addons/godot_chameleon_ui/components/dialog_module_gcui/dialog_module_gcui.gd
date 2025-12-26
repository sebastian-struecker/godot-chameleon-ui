class_name DialogModuleGCUI
extends CenterContainer

signal dialog_open
signal dialog_close

@export var open_button: ButtonGCUI
@export var dialog_scene: PackedScene
@export var ui_layer: int = 30:
	set(value):
		ui_layer = value
		if dialog_layer:
			dialog_layer.layer = value

var _dialog

@onready var background_button: ButtonGCUI = %BackgroundButton
@onready var dialog_layer: CanvasLayer = %DialogLayer


func _ready() -> void:
	background_button.hide()
	open_button.pressed.connect(_on_open_button_pressed)


func _get_configuration_warnings():
	if !background_button:
		return ["Component must be added through %'Instantiate child scene%'"]
	return []


func _on_open_button_pressed() -> void:
	if !dialog_scene:
		return
	if !_dialog:
		_dialog = dialog_scene.instantiate()
		if _dialog.has_signal("close"):
			_dialog.close.connect(_on_dialog_close)
		background_button.pressed.connect(_on_dialog_close)
		dialog_layer.add_child(_dialog)
		dialog_layer.move_child(_dialog, 1)
		background_button.show()
		dialog_open.emit()


func _on_dialog_close() -> void:
	if _dialog.has_signal("close"):
		_dialog.close.disconnect(_on_dialog_close)
	background_button.hide()
	background_button.pressed.disconnect(_on_dialog_close)
	dialog_layer.remove_child(_dialog)
	_dialog = null
	dialog_close.emit()
