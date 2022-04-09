extends PanelContainer
class_name ToolBox

"""

"""

### SIGNAL ###
signal toolbox_options_pressed()
signal toolbox_save_pressed()

### ENUM ###


### CONST ###


### EXPORT ###


### PUBLIC VAR ###


### PRIVATE VAR ###


### ONREADY VAR ###
onready var saveButton = $MarginContainer/HBoxContainer/ButtonGroup/HBoxContainer/Save as IconButton
onready var optionsButton = $MarginContainer/HBoxContainer/ButtonGroup/HBoxContainer/Options as IconButton

### VIRTUAL FUNCTIONS (_init ...) ###
func _ready():
	UTILS.bind(
		optionsButton, "pressed",
		self, "_on_Options_pressed"
	)

	UTILS.bind(
		saveButton, "pressed",
		self, "_on_Save_pressed"
	)


### PUBLIC FUNCTIONS ###


### PRIVATE FUNCTIONS ###


### SIGNAL RESPONSES ###


func _on_Options_pressed():
	emit_signal("toolbox_options_pressed")


func _on_Save_pressed():
	emit_signal("toolbox_save_pressed")
