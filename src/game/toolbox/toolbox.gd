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

onready var copyDateButton = $MarginContainer/HBoxContainer/ButtonGroup/HBoxContainer/HBoxContainer/CopyDateButton as Button
onready var copyTimeButton = $MarginContainer/HBoxContainer/ButtonGroup/HBoxContainer/HBoxContainer/CopyTimeButton as Button


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

	UTILS.bind(
		copyDateButton, "pressed",
		self, "_on_copy_date_pressed"
	)

	UTILS.bind(
		copyTimeButton, "pressed",
		self, "_on_copy_time_pressed"
	)

### PUBLIC FUNCTIONS ###


### PRIVATE FUNCTIONS ###


### SIGNAL RESPONSES ###


func _on_Options_pressed():
	emit_signal("toolbox_options_pressed")


func _on_Save_pressed():
	emit_signal("toolbox_save_pressed")


func _on_copy_date_pressed():
	OS.set_clipboard(UTILS.get_date_string_today())


func _on_copy_time_pressed():
	OS.set_clipboard(UTILS.get_time_string())
