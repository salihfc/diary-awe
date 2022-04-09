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


### PUBLIC FUNCTIONS ###
func load_text(text : String) -> void:
	textEdit.text = text


func get_text() -> String:
	return textEdit.text

### PRIVATE FUNCTIONS ###


### SIGNAL RESPONSES ###
