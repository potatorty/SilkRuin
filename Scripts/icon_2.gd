extends Sprite2D
#script can only be used on nodes Sprite2D

func _ready() -> void: #Only runs once, Create phase
	print('Hello World')
	print("Hello Again!")
	rotation_degrees = 45
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	print("Running Constantly")
	if(position.x <= 1100 and position.x >= 0):
		rotation_degrees += 5
		position.x += 2
	
	
	
