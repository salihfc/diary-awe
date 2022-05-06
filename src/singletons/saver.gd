extends Node

"""

"""

### SIGNAL ###


### ENUM ###


### CONST ###
const SAVE_DIR = "user://diary_awe/diary_data/"
const SAVE_FORMAT = SAVE_DIR + "day_%s.tres"
const SAVE_DATA_CLASS = DiarySave
### EXPORT ###


### PUBLIC VAR ###


### PRIVATE VAR ###


### ONREADY VAR ###


### VIRTUAL FUNCTIONS (_init ...) ###
func _ready():
	var dir = Directory.new()
	dir.make_dir_recursive(SAVE_DIR)


### PUBLIC FUNCTIONS ###
func save_entry(entry_name : String, text : String) -> void:
	var res = SAVE_DATA_CLASS.new(text, entry_name)
	var path = SAVE_FORMAT % entry_name
	var err = ResourceSaver.save(path, res)
	if err != OK:
		assert(0)
	
	LOG.pr(1, "RES SAVE [%s]" % [res.get_date()])


func load_entry(entry_name):
	var path = SAVE_FORMAT % [entry_name]
	if ResourceLoader.exists(path):
		var res = ResourceLoader.load(path)
		LOG.pr(1, "RES LOADED [%s]" % [res.get_date()])
		return res.get_data()
	return ""


func has_entry(entry_name):
	var path = SAVE_FORMAT % [entry_name]
	if ResourceLoader.exists(path):
		var res = ResourceLoader.load(path)
#		LOG.pr(1, "RES LOADED [%s]" % [res.get_date()])
		var text = res.get_data()
		return text.length() > 0
	return false
### PRIVATE FUNCTIONS ###


### SIGNAL RESPONSES ###
