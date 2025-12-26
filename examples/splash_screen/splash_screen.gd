extends Control

@onready var label_gcui: LabelGCUI = $LabelGCUI
@onready var splash_screen_controller: SplashScreenController = $SplashScreenController


func _ready() -> void:
	splash_screen_controller.finished.connect(_on_splash_screen_controller_finished_show)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		label_gcui.hide()
		splash_screen_controller.start()


func _on_splash_screen_controller_finished_show() -> void:
	label_gcui.show()
