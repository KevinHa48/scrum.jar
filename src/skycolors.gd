extends WorldEnvironment

var size_of_third = global.definition / 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var bottom = 0
	for i in range(size_of_third):
		bottom += global.histogram[i]
	bottom /= size_of_third
	
	var middle = 0
	for i in range(size_of_third, size_of_third * 2):
		middle += global.histogram[i]
	middle /= size_of_third
	
	var high = 0
	for i in range(size_of_third * 2, size_of_third * 3):
		high += global.histogram[i]
	high /= size_of_third
	
	self.environment.background_color = Color(bottom, middle, high, 1)
