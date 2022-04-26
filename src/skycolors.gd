extends WorldEnvironment

var size_of_third = global.definition / 3

func histogram_sum(start, end):
	var sum = 0
	for i in range(start * size_of_third, end * size_of_third):
		sum += global.histogram[i]
	return sum / size_of_third


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not global.songplaying or global.safetyMode:
		self.environment.background_color = Color(0, 0, 0, 1)
		return
	var low = histogram_sum(0, 1)
	var middle = histogram_sum(1, 2)
	var high = histogram_sum(2, 3)
	self.environment.background_color = Color(high, middle, low, 1)
