extends VBoxContainer

var scores = global.scores;

# Called when the node enters the scene tree for the first time.
func _ready():
	scores.sort()
	for index in [0,1,2,3,4]:
		if(index <= scores.size()-1):
			var score = scores[index]
			self.get_child(index).get_child(0).text = str(index+1, ". ", score[1], ": ", score[0])
		else:
			self.get_child(index).get_child(0).text = str(index+1, ". N/A")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
