extends Button

export(String) var SCENE_NAME

func _init() -> void:
	connect("pressed", self, "_on_pressed")

func _ready() -> void:
	assert(SCENE_NAME.length() > 0, "%s: Must have a scene name" % [get_path()])
	assert(Global.Scenes.has(SCENE_NAME), "%s: No scene known by name: %s" % [get_path(), SCENE_NAME])

func _on_pressed() -> void:
	var e = Global.goto_scene(SCENE_NAME)
	if e != OK:
		push_error("%s: Got error %d while trying to load scene %s" % [get_path(), e, SCENE_NAME])
