extends ProgressBar

# Called when the node enters the scene tree for the first time.
func set_exp_bar():
	if Game.xp >= 100:
		Game.level += 1
		Game.xp = Game.xp - 100
	value = Game.xp
	
