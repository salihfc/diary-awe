extends PanelContainer

"""

"""

### SIGNAL ###


### ENUM ###


### CONST ###
const ColorOptionPickerPrefab = preload("res://src/game/dict_editor/color_option_picker.tscn")

### EXPORT ###


### PUBLIC VAR ###


### PRIVATE VAR ###


### ONREADY VAR ###
onready var wordList = $VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/WordList as VBoxContainer
onready var wordLineEdit = $VBoxContainer/HBoxContainer/WordLineEdit as LineEdit

### VIRTUAL FUNCTIONS (_init ...) ###
func _ready():
	var all_words = CONFIG.get_all_words()
	for word in all_words:
		var color = CONFIG.get_word_color(word)
		add_word(word, color)


### PUBLIC FUNCTIONS ###


### PRIVATE FUNCTIONS ###
func _is_word_valid(_word : String) -> bool:
	return _word.length() > 0


### SIGNAL RESPONSES ###
func _on_AddWordButton_pressed():
	add_word(wordLineEdit.text)


func add_word(word : String, color := Color.white) -> void:
	if _is_word_valid(word):
		var new_option = ColorOptionPickerPrefab.instance()
		wordList.add_child(new_option)
		UTILS.bind(
			new_option, "option_updated",
			self, "_on_word_color_updated"
		)
		new_option.set_word(word)
		new_option.set_color(color)



func _on_word_color_updated(word : String, color : Color) -> void:
	CONFIG.set_word_color(word, color)
