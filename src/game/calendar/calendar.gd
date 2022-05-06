extends PanelContainer
class_name Calendar

"""

"""

### SIGNAL ###
signal day_selected(year, month, day)

### ENUM ###


### CONST ###
const DAY_CT = [
	0,
	31,
	28,
	31,
	30,
	31,
	30,
	31,
	31,
	30,
	31,
	30,
	31
]

const CalendarButton = preload("res://src/game/calendar/calendar_button.tscn")

### EXPORT ###


### PUBLIC VAR ###


### PRIVATE VAR ###


### ONREADY VAR ###
onready var yearLabel = $VBoxContainer/YearLabel as Label
onready var dayMatrix = $VBoxContainer/DayMatrix as HBoxContainer

### VIRTUAL FUNCTIONS (_init ...) ###


### PUBLIC FUNCTIONS ### 
func load_year(year : int) -> void:
	_clear()
	_fill(year)



### PRIVATE FUNCTIONS ###
func _clear() -> void:
	for column in dayMatrix.get_children():
		UTILS.remove_all_chilren(column)


func _fill(year : int) -> void:
	yearLabel.text = str(year)
	
	var current_date_arr = UTILS.date_array()

	for column in dayMatrix.get_children():
		var month = column.get_index() + 1
		var days = _get_days_in_month(year, month)
		for day in range(1, days + 1):
			var button = CalendarButton.instance()
			button.text = str(day % 10)
			column.add_child(button)
			
			UTILS.bind(
				button, "pressed",
				self, "_on_button_pressed",
				[year, month, day]
			)
			
			# EXTRA MODS 
			var comparison = UTILS.compare_date_arrays(current_date_arr, [year, month, day])
			if comparison == 1:
				button.disabled = true
			elif comparison == 0: # same day [green]
				button.self_modulate = Color("7bff69")
			else:
				if SAVER.has_entry(UTILS.get_date_string(day, month, year)):
					button.self_modulate = Color("ff697b")
				else:
					button.self_modulate = Color("5958fd")


func _get_days_in_month(year : int, month : int) -> int:
	var days = DAY_CT[month]
	if month == 2 and _is_leap_year(year):
		days += 1
	return days


func _is_leap_year(year : int) -> bool:
	return (year % 400 == 0) or ((year % 100) and (year % 4 == 0))


### SIGNAL RESPONSES ###
func _on_button_pressed(year : int, month : int, day : int) -> void:
	emit_signal("day_selected", year, month, day)
