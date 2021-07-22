extends Button

export(String) var SCENE_KEY

func _init() -> void:
	connect("pressed", self, "_on_pressed")

func _on_pressed() -> void:
	Global.goto_scene(SCENE_KEY)
