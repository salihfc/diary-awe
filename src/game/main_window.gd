extends Control

"""

"""

### SIGNAL ###
signal main_menu_option_pressed()

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
onready var dateLabel = $HBoxContainer/VBoxContainer/DateLabel as Label
onready var autoSaveTimer = $AutoSaveTimer as Timer

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
	
	UTILS.bind(
		autoSaveTimer, "timeout",
		self, "_on_AutoSaveTimer_timeout"
	)
	
	calendar.load_year(2022)
	var datetime = OS.get_datetime(true)
	_on_calendar_day_selected(datetime["year"], datetime["month"], datetime["day"])

	autoSaveTimer.start(CONFIG.AUTO_SAVE_PERIOD)


### PUBLIC FUNCTIONS ###


### PRIVATE FUNCTIONS ###
func _get_date_string(day, month, year) -> String:
	var day_str = str(day).pad_zeros(2)
	var month_str = str(month).pad_zeros(2)
	var year_str = str(year).pad_zeros(4)
	return "%s.%s.%s" % [year_str, month_str, day_str]


func _save_entry():
	var text = editor.get_text()
	SAVER.save_entry(_last_selected_entry, text)


### SIGNAL RESPONSES ###
func _on_options_pressed():
	emit_signal("main_menu_option_pressed")
	LOG.pr(1, "Options button pressed")


func _on_save_pressed():
	LOG.pr(1, "Save button pressed")
	_save_entry()


func _on_calendar_day_selected(year : int, month : int, day : int) -> void:
	_last_selected_entry = _get_date_string(day, month, year)
	LOG.pr(1, "Calendar day selected: %s" % _last_selected_entry)
	var text = SAVER.load_entry(_last_selected_entry)
	editor.load_text(text)
	
	dateLabel.text = (_last_selected_entry)
	var comp = UTILS.compare_with_today([year, month, day])
	if comp == -1:
		editor.disable_edit()
	elif comp == 0:
		editor.disable_edit(false)


func _on_AutoSaveTimer_timeout():
	LOG.pr(1, "Auto Save started [%s]" % [_last_selected_entry])
	_save_entry()
	autoSaveTimer.start(CONFIG.AUTO_SAVE_PERIOD)
