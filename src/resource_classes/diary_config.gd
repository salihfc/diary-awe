extends Resource
class_name DiaryConfig

"""

"""

### SIGNAL ###


### ENUM ###


### CONST ###


### EXPORT ###
export(Dictionary) var color_dict


### PUBLIC VAR ###


### PRIVATE VAR ###


### ONREADY VAR ###


### VIRTUAL FUNCTIONS (_init ...) ###


### PUBLIC FUNCTIONS ###
func set_word_color(word : String, color : Color) -> void:
	color_dict[word] = color


func get_word_color(word : String) -> Color:
	if word in color_dict:
		return color_dict[word]
	return Color.white

### PRIVATE FUNCTIONS ###


### SIGNAL RESPONSES ###
