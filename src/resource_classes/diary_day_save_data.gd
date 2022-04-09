extends Resource
class_name DiarySave

export(String) var data
export(String) var date

func _init(_data = "empty", _date = "date"):
	data = _data
	date = _date

func get_data():
	return data

func get_date():
	return date
