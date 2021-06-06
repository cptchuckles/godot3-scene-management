# Scene management in Godot 3.x

Say you wanted to use `export(PackedScene)` vars to reference the different scenes in your game for transitions from one scene to another.  This is a great idea because by using `export(PackedScene)` vars, the Godot editor will update resource paths for you if you ever move or rename them from inside of the Godot editor's FileSystem pane, meaning you do not have to hard-code resource paths into `load()` and `preload()` calls anymore.

However, in Godot 3.x, scenes referenced to each other as export vars will create an infinite dependency cycle.  The Godot scene loader must recursively parse all `.tscn` files in order to load a scene, and when an `ext_resource` names another `.tscn`, that one must be parsed before the scene loader can go on.  If two `.tscn` files list *each other* as `ext_resource`s, this creates infinite recursion, and the Godot scene loader fails.  The answer is to create an Autoload Singleton which holds all of the needed scene references, and let every other scene use this interface instead of linking scenes together directly.  Since the autoload singleton `.tscn` is never named as `ext_resource` in any of the other `.tscn` files, there is no infinite recursion.

In order to make indexing other scenes easier, I chose to `export` a `Dictionary` instead of an `Array(PackedScene)`, so that code from all my other scenes could use a human-readable name as a key for another scene instead of having to lookup the index for a scene every time I used the Singleton.  The only drawback in 3.x is that `export(Dictionary)` cannot take type hints.  This means that for every new scene I want to index in the Singleton's dictionary, I have to go through all the clicks to specify that the new key is a String, the new value is a `Resource`, and then I can drag another `.tscn` onto the Value field before clicking "Add new key/value pair".  It is a bit of tedium, but this setup only has to be done *once*, and then each scene can be used by its human-readable key name from everywhere else in the project.