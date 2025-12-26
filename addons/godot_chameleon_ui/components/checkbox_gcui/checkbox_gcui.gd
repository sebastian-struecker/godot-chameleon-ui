@tool
class_name CheckboxGCUI
extends CenterContainer

signal click_sound
signal focus_sound
signal toggle

const BASE_TYPE: ChameleonUI.BASE_TYPE = ChameleonUI.BASE_TYPE.CHECK_BOX
const THEME_CHECKED_ICON: String = "checked"
const THEME_CHECKED_DISABLED_ICON: String = "checked_disabled"
const THEME_UNCHECKED_ICON: String = "unchecked"
const THEME_UNCHECKED_DISABLED_ICON: String = "unchecked_disabled"
const ThemeValidationGcui = preload("../../utilities/theme_validation_gcui/theme_validation_gcui.gd")

@export var control_theme: Theme:
	set(value):
		control_theme = value
		_update_from_theme(value)
		update_configuration_warnings()
@export var checked = false:
	set(value):
		checked = value
		_update_elements()
@export var disabled = false:
	set(value):
		disabled = value
		_update_elements()
@export_range(1, 999, 1) var width: int = 32:
	set(value):
		width = value
		var vector = Vector2(value, value)
		size = vector
		_set_control_size(%Button, vector)
		_set_control_size(%CheckedTexture, vector)
		_set_control_size(%UncheckedTexture, vector)
		_set_control_size(%DisabledCheckedTexture, vector)
		_set_control_size(%DisabledUncheckedTexture, vector)

var THEME_REQUIREMENTS: ThemeRequirements = ThemeRequirements.new(true, [], ["checked", "checked_disabled", "unchecked", "unchecked_disabled"])
var THEME_CHECK_BOX: String = ChameleonUI.base_types.get(BASE_TYPE, "")

@onready var button: Button = %Button
@onready var checked_texture: TextureRect = %CheckedTexture
@onready var unchecked_texture: TextureRect = %UncheckedTexture
@onready var disabled_checked_texture: TextureRect = %DisabledCheckedTexture
@onready var disabled_unchecked_texture: TextureRect = %DisabledUncheckedTexture


func _ready() -> void:
	_update_elements()
	_connect_signals()


func _get_configuration_warnings():
	if !button:
		return ["Component must be added through %'Instantiate child scene%'"]
	return ThemeValidationGcui.validate_theme(control_theme, THEME_REQUIREMENTS, BASE_TYPE)


func _connect_signals() -> void:
	if !button.pressed.is_connected(_on_button_pressed):
		button.pressed.connect(_on_button_pressed)
	if !button.mouse_entered.is_connected(_on_mouse_entered):
		button.mouse_entered.connect(_on_mouse_entered)
	if !button.focus_entered.is_connected(_on_button_focused_entered):
		button.focus_entered.connect(_on_button_focused_entered)


func _update_from_theme(theme: Theme) -> void:
	if !theme:
		return
	if checked_texture && theme.has_icon(THEME_CHECKED_ICON, THEME_CHECK_BOX):
		checked_texture.texture = theme.get_icon(THEME_CHECKED_ICON, THEME_CHECK_BOX)
	if unchecked_texture && theme.has_icon(THEME_UNCHECKED_ICON, THEME_CHECK_BOX):
		unchecked_texture.texture = theme.get_icon(THEME_UNCHECKED_ICON, THEME_CHECK_BOX)
	if disabled_checked_texture && theme.has_icon(THEME_CHECKED_DISABLED_ICON, THEME_CHECK_BOX):
		disabled_checked_texture.texture = theme.get_icon(THEME_CHECKED_DISABLED_ICON, THEME_CHECK_BOX)
	if disabled_unchecked_texture && theme.has_icon(THEME_UNCHECKED_DISABLED_ICON, THEME_CHECK_BOX):
		disabled_unchecked_texture.texture = theme.get_icon(THEME_UNCHECKED_DISABLED_ICON, THEME_CHECK_BOX)


func _update_elements() -> void:
	if !checked_texture:
		return
	if !unchecked_texture:
		return
	if !disabled_checked_texture:
		return
	if !disabled_unchecked_texture:
		return
	checked_texture.hide()
	unchecked_texture.hide()
	disabled_checked_texture.hide()
	disabled_unchecked_texture.hide()
	if disabled:
		if checked:
			disabled_checked_texture.show()
		else:
			disabled_unchecked_texture.show()
	else:
		if checked:
			checked_texture.show()
		else:
			unchecked_texture.show()


func _set_control_size(control: Control, vector: Vector2) -> void:
	control.size = vector
	control.custom_minimum_size = vector


func _on_button_pressed() -> void:
	if disabled:
		return
	checked = !checked
	click_sound.emit()
	toggle.emit()


func _on_mouse_entered() -> void:
	button.grab_focus()


func _on_button_focused_entered() -> void:
	focus_sound.emit()
