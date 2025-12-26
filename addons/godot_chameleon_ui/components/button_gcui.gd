@tool
class_name ButtonGCUI
extends Button

signal click_sound
signal focus_sound

enum FOCUS_TYPE {
	NONE,
	ALL,
}

const BASE_TYPE: ChameleonUI.BASE_TYPE = ChameleonUI.BASE_TYPE.BUTTON
const FontSizeGcui = preload("../utilities/font_size_gcui.gd")
const SeparationGcui = preload("../utilities/separation_gcui.gd")
const TransparencyMaterialGcui = preload("../utilities/transparency_material_gcui/transparency_material_gcui.gd")

@export var control_theme: Theme:
	set(value):
		control_theme = value
		theme = value
		_update_from_theme(value)
@export_range(0, 999, 1) var font_size: int = 16:
	set(value):
		font_size = value
		FontSizeGcui.font_size(self, value)
@export var focus_type: FOCUS_TYPE = FOCUS_TYPE.NONE:
	set(value):
		focus_type = value
		match focus_type:
			FOCUS_TYPE.NONE:
				focus_mode = FOCUS_NONE
			FOCUS_TYPE.ALL:
				focus_mode = FOCUS_ALL
@export_range(0, 1, 0.01) var transparency: float = 1.0:
	set(value):
		transparency = value
		TransparencyMaterialGcui.transparency(self, value)
@export var separation: int = 4:
	set(value):
		separation = value
		SeparationGcui.separation(self, value)

var default_scale: Vector2


func _ready() -> void:
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	expand_icon = true
	default_scale = scale
	_connect_signals()


func _connect_signals() -> void:
	if !focus_entered.is_connected(_on_focus_entered):
		focus_entered.connect(_on_focus_entered)
	if !mouse_entered.is_connected(_on_mouse_entered):
		mouse_entered.connect(_on_mouse_entered)
	if !mouse_exited.is_connected(_on_mouse_exited):
		mouse_exited.connect(_on_mouse_exited)
	if !pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)


func _update_from_theme(_theme: Theme) -> void:
	if _theme:
		font_size = ThemeUtilsGCUI.get_font_size(_theme, BASE_TYPE)
	else:
		font_size = 16


func _on_pressed() -> void:
	click_sound.emit()


func _on_mouse_entered() -> void:
	if focus_type == FOCUS_TYPE.NONE:
		return
	grab_focus()


func _on_mouse_exited() -> void:
	if focus_type == FOCUS_TYPE.NONE:
		return
	#release_focus()


func _on_focus_entered() -> void:
	focus_sound.emit()
