@tool
class_name DropdownGCUI
extends OptionButton

signal click_sound
signal focus_sound

const BASE_TYPE: ChameleonUI.BASE_TYPE = ChameleonUI.BASE_TYPE.DROPDOWN

@export var control_theme: Theme:
	set(value):
		control_theme = value
		theme = value


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	if !focus_entered.is_connected(_on_focus_entered):
		focus_entered.connect(_on_focus_entered)
	if !pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)
	if !item_focused.is_connected(_on_item_focused):
		item_focused.connect(_on_item_focused)
	if !item_selected.is_connected(_on_item_selected):
		item_selected.connect(_on_item_selected)


func _on_pressed() -> void:
	click_sound.emit()


func _on_focus_entered() -> void:
	focus_sound.emit()


func _on_item_selected(_index: int) -> void:
	click_sound.emit()


func _on_item_focused(_index: int) -> void:
	focus_sound.emit()
