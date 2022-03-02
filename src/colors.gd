extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if(delta % 20.0 == 0) :
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var rand1 = rng.randf_range(0,1)
		var rand2 = rng.randf_range(0,1)
		var rand3 = rng.randf_range(0,1)
		var rand4 = rng.randf_range(0,1)
		var material = SpatialMaterial.new()
		material.albedo_color = Color(rand1,rand2,rand3,rand4)
		$MeshInstance.material_override = material	
	pass
