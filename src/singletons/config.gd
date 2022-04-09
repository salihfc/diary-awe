extends Node

const AUTO_SAVE_MIN = 1
const AUTO_SAVE_PERIOD = 60 * AUTO_SAVE_MIN
const CONFIG_SAVE_DIR = "user://diary_awe/"
const CONFIG_FILENAME = "diary_config.tres"
var config_file


func _ready() -> void:
	LOG.pr(3, "READY", "CONFIG")
	OS.center_window()
	Engine.target_fps = 60
	
	var config_file_path = CONFIG_SAVE_DIR + CONFIG_FILENAME
	config_file = load(config_file_path)
	if config_file == null:
		var dir = Directory.new()
		dir.make_dir_recursive(CONFIG_SAVE_DIR)
		var new_config = DiaryConfig.new()
		var err = ResourceSaver.save(config_file_path, new_config)
		if err != OK:
			assert(0)

		config_file = load(config_file_path)


func set_word_color(word : String, color : Color) -> void:
	config_file.set_word_color(word, color)
	var err = ResourceSaver.save(CONFIG_SAVE_DIR + CONFIG_FILENAME, config_file)
	if err != OK:
		assert(0)


func get_word_color(word : String) -> Color:
	return config_file.get_word_color(word)


func get_all_words() -> Array:
	return config_file.color_dict.keys()
