extends Control
class_name Editor

"""

"""

### SIGNAL ###


### ENUM ###


### CONST ###


### EXPORT ###


### PUBLIC VAR ###


### PRIVATE VAR ###


### ONREADY VAR ###
onready var textEdit = $PanelContainer/MarginContainer/TextEdit as TextEdit


### VIRTUAL FUNCTIONS (_init ...) ###
func _ready():
	textEdit.text = ""

	var all_words = CONFIG.get_all_words()
#	LOG.pr(4, "[%s]: [%s]" % [all_words.size(), all_words])
	for word in all_words:
		var color = CONFIG.get_word_color(word)
		textEdit.add_keyword_color(word, color)


### PUBLIC FUNCTIONS ###
func load_text(text : String) -> void:
	textEdit.text = text


func get_text() -> String:
	return textEdit.text


func disable_edit(disable = true) -> void:
	textEdit.readonly = disable


### PRIVATE FUNCTIONS ###


### SIGNAL RESPONSES ###
