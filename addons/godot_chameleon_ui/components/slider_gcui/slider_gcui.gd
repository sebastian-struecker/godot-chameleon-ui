@tool
class_name SliderGCUI
extends CenterContainer

signal click_sound
signal focus_sound
signal value_changed(value: float)

enum SLIDER_DIRECTION {
	HORIZONTAL,
	VERTICAL,
}

enum LABEL_DIRECTION {
	TOP,
	RIGHT,
	BOTTOM,
	LEFT,
}

@export var control_theme: Theme:
	set(value):
		control_theme = value
		theme = value
		_update_from_theme(value)
@export var value: float = 0:
	set(v):
		value = v
		h_slider.value = value
		v_slider.value = value
		value_label_top.text = str(int(value))
		value_label_bottom.text = str(int(value))
@export var disabled: bool = false
@export var debounce_time: float = 0.5:
	set(value):
		debounce_time = value
		debounce.delay_time = value

@export_group("Label")
@export var display_value_label: bool = false:
	set(value):
		display_value_label = value
		call_deferred("_display_correct_parts")
@export var label_font_size: int = 16:
	set(value):
		label_font_size = value
		value_label_top.font_size = value
		value_label_bottom.font_size = value
@export var label_separation: int = 8:
	set(value):
		label_separation = value
		box_container.separation = value
@export var label_direction: LABEL_DIRECTION = LABEL_DIRECTION.RIGHT:
	set(value):
		label_direction = value
		call_deferred("_display_correct_parts")

@export_group("Style")
@export var direction: SLIDER_DIRECTION = SLIDER_DIRECTION.HORIZONTAL:
	set(value):
		direction = value
		call_deferred("_display_correct_parts")
		call_deferred("_set_correct_size")
@export var length: int = 150:
	set(value):
		length = value
		call_deferred("_set_correct_size")
@export var height: int = 24:
	set(value):
		height = value
		call_deferred("_set_correct_size")

@onready var debounce: Debounce = $Debounce
@onready var box_container: BoxContainerGCUI = %BoxContainer
@onready var h_slider: HSlider = %HSlider
@onready var v_slider: VSlider = %VSlider
@onready var value_label_top: LabelGCUI = %ValueLabelTop
@onready var value_label_bottom: LabelGCUI = %ValueLabelBottom


func _ready() -> void:
	_display_correct_parts()
	_set_correct_size()
	_set_value_across_parts(value)
	_connect_signals()


func _get_configuration_warnings():
	if !debounce:
		return ["Component must be added through %'Instantiate child scene%'"]
	return []


func _connect_signals() -> void:
	if !h_slider.value_changed.is_connected(_on_slider_value_changed):
		h_slider.value_changed.connect(_on_slider_value_changed)
	if !v_slider.value_changed.is_connected(_on_slider_value_changed):
		v_slider.value_changed.connect(_on_slider_value_changed)
	if !h_slider.focus_entered.is_connected(_on_slider_focus_entered):
		h_slider.focus_entered.connect(_on_slider_focus_entered)
	if !v_slider.focus_entered.is_connected(_on_slider_focus_entered):
		v_slider.focus_entered.connect(_on_slider_focus_entered)


func _update_from_theme(_theme: Theme) -> void:
	if _theme:
		label_font_size = ThemeUtilsGCUI.get_font_size(_theme, ChameleonUI.BASE_TYPE.LABEL)
	else:
		label_font_size = 16


func _display_correct_parts() -> void:
	h_slider.hide()
	v_slider.hide()
	value_label_top.hide()
	value_label_bottom.hide()
	match direction:
		SLIDER_DIRECTION.HORIZONTAL:
			h_slider.show()
		SLIDER_DIRECTION.VERTICAL:
			v_slider.show()
	match label_direction:
		LABEL_DIRECTION.TOP:
			box_container.type = BoxContainerGCUI.TYPE.VERTICAL
			box_container.layout_direction = Control.LAYOUT_DIRECTION_INHERITED
			if display_value_label:
				value_label_top.show()
		LABEL_DIRECTION.RIGHT:
			box_container.type = BoxContainerGCUI.TYPE.HORIZONTAL
			box_container.layout_direction = Control.LAYOUT_DIRECTION_LTR
			if display_value_label:
				value_label_bottom.show()
		LABEL_DIRECTION.BOTTOM:
			box_container.type = BoxContainerGCUI.TYPE.VERTICAL
			box_container.layout_direction = Control.LAYOUT_DIRECTION_INHERITED
			if display_value_label:
				value_label_bottom.show()
		LABEL_DIRECTION.LEFT:
			box_container.type = BoxContainerGCUI.TYPE.HORIZONTAL
			box_container.layout_direction = Control.LAYOUT_DIRECTION_RTL
			if display_value_label:
				value_label_bottom.show()


func _set_correct_size() -> void:
	var vector: Vector2 = Vector2.ZERO
	match direction:
		SLIDER_DIRECTION.HORIZONTAL:
			vector = Vector2(length, height)
		SLIDER_DIRECTION.VERTICAL:
			vector = Vector2(height, length)
	h_slider.custom_minimum_size = vector
	v_slider.custom_minimum_size = vector
	custom_minimum_size = vector
	h_slider.size = vector
	v_slider.size = vector
	set_deferred("size", vector)


func _set_value_across_parts(_value: float) -> void:
	value = _value
	click_sound.emit()
	value_changed.emit(value)


func _on_slider_value_changed(_value: float) -> void:
	if disabled:
		return
	debounce.debounce(_set_value_across_parts.bind(_value))


func _on_slider_focus_entered() -> void:
	focus_sound.emit()
