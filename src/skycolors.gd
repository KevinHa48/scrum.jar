extends WorldEnvironment


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.environment.background_color = Color(
		global.histogram[20], global.histogram[30], global.histogram[40], 1)
