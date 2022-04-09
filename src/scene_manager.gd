extends CanvasLayer

"""

"""

### SIGNAL ###


### ENUM ###
enum SCENE {
	MAIN_WINDOW,
	DICT_EDITOR,
}

const SCENES = {
	SCENE.MAIN_WINDOW : preload("res://src/game/main_window.tscn"),
	SCENE.DICT_EDITOR : preload("res://src/game/dict_editor/dict_editor.tscn"),
}


### CONST ###
const DEFAULT_FOREGROUND_COLOR = Color("0c0d1d")
const FULL_TRANSPARENT = Color(0.0, 0.0, 0.0, 0.0)
const FADE_MIN_DELAY = 0.1
const RECOVERY_MIN_DELAY = 0.5

const STARTING_SCENE = SCENE.MAIN_WINDOW

### EXPORT ###


### PUBLIC VAR ###


### PRIVATE VAR ###
var _current_scene = null

### ONREADY VAR ###
onready var foreground = $Control/Foreground as ColorRect
onready var sceneSlot = $CurrentSceneSlot as Control


### VIRTUAL FUNCTIONS (_init ...) ###

func _ready() -> void:
	LOG.pr(3, "READY", "SCENE_MANAGER")
	set_foreground_color(DEFAULT_FOREGROUND_COLOR)
	change_scene(STARTING_SCENE)


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		match _current_scene:
			SCENE.MAIN_WINDOW:
				get_tree().quit()
			SCENE.DICT_EDITOR:
				change_scene(SCENE.MAIN_WINDOW)


### PUBLIC FUNCTIONS ###
func set_foreground_color(new_color : Color) -> void:
	foreground.color = new_color


func change_scene(scene_id) -> void:
	fade(1.0, FADE_MIN_DELAY)
	if sceneSlot.get_child_count():
		var current_scene = sceneSlot.get_child(0)
		current_scene.queue_free()

	var scene = SCENES[(scene_id)].instance()
	scene.visible = false
	sceneSlot.add_child(scene)
	configure_scene_signals(scene_id, scene)
	_current_scene = scene_id

	# TODO: Should wait until scene fully loaded
	yield(get_tree().create_timer(1.0), "timeout")
	fade(0.0, RECOVERY_MIN_DELAY)
	scene.visible = true


func fade(alpha, duration := 0.5) -> void:
	var to = foreground.color
	to.a = alpha
	
	TWEEN.interpolate_property(
			foreground, "color", 
			foreground.color, to,
			duration,
			Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)


# warning-ignore:unused_argument
func configure_scene_signals(id, scene) -> void:
	
	match id:
		SCENE.MAIN_WINDOW:
			UTILS.bind(
				scene, "main_menu_option_pressed",
				self, "_on_scene_change_requested",
				[SCENE.DICT_EDITOR]
			)
			pass

		SCENE.DICT_EDITOR:
			pass

		_:
			pass
 

func _on_scene_change_requested(scene_id : int) -> void:
	change_scene(scene_id)
