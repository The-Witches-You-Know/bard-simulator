extends SaveData

class_name Game_Data

func _init(_fileName: String):
	fileName = _fileName
	saveFile = ConfigFile.new()
