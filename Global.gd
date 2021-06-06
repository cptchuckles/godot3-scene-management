extends Node

export(Dictionary) var Scenes
"""
This needs to be populated via the Inspector if you want the scenes' Resource Paths to update
dynamically as you move things around and rename them via Godot's built-in FileSystem pane.

It is a massive convenience to be able to refer to scene names via a simple string when
attempting to go to that scene, and also creates a single point of access that's globally
accessible to all scripts throughout the project, which elides the circular reference problem.
"""


func _ready() -> void:
  print(var2str(Scenes))

func goto_scene(name: String) -> void:
  get_tree().change_scene_to(Scenes[name])
