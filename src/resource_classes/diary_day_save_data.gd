extends Resource
class_name DiarySave

export(String) var data

func _init(_data = "empty"):
	data = _data

func get_data():
	return data
