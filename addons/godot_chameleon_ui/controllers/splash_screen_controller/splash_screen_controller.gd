# reference: https://www.youtube.com/watch?v=QKAuacUG0y4&list=PLEHvj4yeNfeGiG6ZJXDymk5dYBAjCGiwe&index=5
@tool
class_name SplashScreenController
extends CenterContainer

signal started
signal finished
signal stopped

@export var screen_time: float = 1
@export var fade_out_time: float = 1
@export var fade_in_time: float = 1

var splash_screens: Array[TextureRect] = []


func _ready() -> void:
	_setup_splash_screens()


func start() -> void:
	started.emit()
	show()
	for screen in splash_screens:
		var tween: Tween = create_tween()
		tween.tween_property(screen, "modulate:a", 1.0, fade_in_time)
		tween.tween_interval(screen_time)
		tween.tween_property(screen, "modulate:a", 0.0, fade_out_time)
		await tween.finished
	hide()
	finished.emit()


func stop() -> void:
	hide()
	for splash_screen in splash_screens:
		splash_screen.modulate.a = 0.0
	stopped.emit()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	var children: Array[Node] = get_children()
	if children.is_empty():
		warnings.append("Splash Screens are missing")
	for child in children:
		if child is not TextureRect:
			warnings.append(str("The child: ", child.get_instance_id(), " is not a TextureRect"))
	return warnings


func _setup_splash_screens() -> void:
	var children: Array[Node] = get_children()
	for child in children:
		if child is TextureRect:
			splash_screens.append(child)
	for splash_screen in splash_screens:
		splash_screen.modulate.a = 0.0
