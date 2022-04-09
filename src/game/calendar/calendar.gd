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
	yearLabel.text = str(year)
	
	for month_column in dayMatrix.get_children():
		var month = month_column.get_index() + 1
		var days = _get_days_in_month(year, month)
		for day in range(1, days + 1):
			var button = CalendarButton.instance()
			button.text = str(day % 10)
			month_column.add_child(button)
			
			UTILS.bind(
				button, "pressed",
				self, "_on_button_pressed",
				[year, month, day]
			)


### PRIVATE FUNCTIONS ###
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _get_days_in_month(year : int, month : int) -> int:
	var days = DAY_CT[month]
	if month == 2 and _is_leap_year(year):
		days += 1
	return days


func _is_leap_year(year : int) -> bool:
	return (year % 400 == 0) or ((year % 100) and (year % 4 == 0))

### SIGNAL RESPONSES ###
# warning-ignore:unused_argument
# warning-ignore:unused_argument 
# warning-ignore:unused_argument
func _on_button_pressed(year : int, month : int, day : int) -> void:
	emit_signal("day_selected", year, month, day)
