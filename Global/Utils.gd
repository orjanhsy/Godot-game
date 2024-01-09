extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"gold": Game.gold,
		"exp": Game.xp,
		"level": Game.level,
	}
	
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
		
		
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string((file.get_line()))
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.gold = current_line["gold"]
				Game.xp = current_line["exp"]
				Game.level = current_line["level"]
