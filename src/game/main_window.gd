extends Control

"""

"""

### SIGNAL ###


### ENUM ###


### CONST ###


### EXPORT ###


### PUBLIC VAR ###


### PRIVATE VAR ###
var _last_selected_entry = null

### ONREADY VAR ###
onready var toolbox = $HBoxContainer/VBoxContainer/ToolBox as ToolBox
onready var editor = $HBoxContainer/VBoxContainer/Editor as Editor
onready var calendar = $HBoxContainer/CalendarNavigation/PanelContainer/MarginContainer/VBoxContainer/Calendar as Calendar

### VIRTUAL FUNCTIONS (_init ...) ###
func _ready():
	UTILS.bind(
		toolbox, "toolbox_options_pressed",
		self, "_on_options_pressed"
	)

	UTILS.bind(
		toolbox, "toolbox_save_pressed",
		self, "_on_save_pressed"
	)
	
	UTILS.bind(
		calendar, "day_selected",
		self, "_on_calendar_day_selected"
	)
	
	calendar.load_year(2022)
	var datetime = OS.get_datetime(true)
	_on_calendar_day_selected(datetime["year"], datetime["month"], datetime["day"])

### PUBLIC FUNCTIONS ###


### PRIVATE FUNCTIONS ###
func _get_date_string(day, month, year) -> String:
	var day_str = str(day).pad_zeros(2)
	var month_str = str(month).pad_zeros(2)
	var year_str = str(year).pad_zeros(4)
	return "%s.%s.%s" % [year_str, month_str, day_str]


### SIGNAL RESPONSES ###
func _on_options_pressed():
	LOG.pr(1, "Options button pressed")


func _on_save_pressed():
	LOG.pr(1, "Save button pressed")
	var text = editor.get_text()
	SAVER.save_entry(_last_selected_entry, text)


func _on_calendar_day_selected(year : int, month : int, day : int) -> void:
	_last_selected_entry = _get_date_string(day, month, year)
	LOG.pr(1, "Calendar day selected: %s" % _last_selected_entry)
	var text = SAVER.load_entry(_last_selected_entry)
	editor.load_text(text)
