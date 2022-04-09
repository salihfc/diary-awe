extends PanelContainer
class_name ColorOptionPicker

"""

"""

### SIGNAL ###
signal option_updated(word, color)

### ENUM ###


### CONST ###


### EXPORT ###


### PUBLIC VAR ###


### PRIVATE VAR ###


### ONREADY VAR ###
onready var label = $HBoxContainer/WordLabel as Label
onready var colorPickerButton = $HBoxContainer/ColorPickerButton as ColorPickerButton

### VIRTUAL FUNCTIONS (_init ...) ###
func _ready():
	colorPickerButton.color = Color.white


### PUBLIC FUNCTIONS ###
func set_word(new_word : String) -> void:
	label.text = new_word


func set_color(color : Color) -> void:
	colorPickerButton.color = color

### PRIVATE FUNCTIONS ###


### SIGNAL RESPONSES ###
func _on_ColorPickerButton_color_changed(color):
	emit_signal("option_updated", label.text, color)
