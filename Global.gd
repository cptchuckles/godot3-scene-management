extends Node

export(Dictionary) var Scenes
"""
Types should be String => PackedScene, but sadly it is impossible to give type hints
for Dictionaries.

This needs to be populated via the Inspector if you want the scenes' Resource Paths to update
dynamically as you move things around and rename them via Godot's built-in FileSystem pane.

It is a massive convenience to be able to refer to scene names via a simple string when
attempting to go to that scene, and also creates a single point of access that's globally
accessible to all scripts throughout the project, which elides the circular reference problem.
"""


func _ready() -> void:
	print_debug(var2str(Scenes))


func goto_scene(scene_name: String) -> int:
	if not scene_name in Scenes:
		return ERR_DOES_NOT_EXIST

	return get_tree().change_scene_to(Scenes.get(scene_name))
