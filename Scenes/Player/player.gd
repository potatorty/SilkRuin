extends CharacterBody2D
class_name Player

#@export function creates a variable that you can edit in the node's inspector
#This is also only allowed outside of functions
@export var Hp: int #automatically set to zero, @export functions also need to be defined with a type
@export var move_speed: float = 100 
@export var push_force : float = 150
@export var test = "export can also have an initializer instead of type defined"
#Variables defined outside of the functions scope through the whole code.
var ex_scope 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Runs once when the node is on the scene tree for the first time.
	position = SceneManager.player_scene_position
	
	
	#SceneManager.player_scene_position = player.postition
	pass

#Change motion mode to Floating. Defines behavior of move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#The inputs move_left, move_right, move_up, move_down are creatied in the input map under project settings
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down") #gives vector with x and y
	#calculates the below values based on the inputs, returning us one Vector2(x, y) which will determine where the player moves
	#(-1, 0), (1, 0), (0, -1), (0, 1)
	#print(move_vector)
	
	#velocity of the player
	velocity = move_vector * move_speed
	
	#important: notice that elif was used here instead of all if statements.
	#if we used if statements, our player animation will freeze when moving diagonally
	# as it tries to run 2 animations at once
	if(velocity.x < 0):
		#print("player is moving left")
		$AnimatedSprite2D.play("walk_left")
	elif(velocity.x > 0):
		#print("Player is moving right")
		$AnimatedSprite2D.play("walk_right")
	elif(velocity.y < 0):
		#print("Player is moving up")
		$AnimatedSprite2D.play("walk_up")
	elif(velocity.y > 0):
		#print("Player is moving down")
		$AnimatedSprite2D.play("walk_down")
	else:
		#print("Player stopped moving")
		$AnimatedSprite2D.stop()
	#elif(velocity.x == 0 && velocity.y == 0):
		#print("Player stopped moving")
		#$AnimatedSprite2D.stop()
		
	move_and_slide() #uses the variable velocity to determine player movement
	
	#Process of playermovement: 
	#1- Create movements in input map
	#2 - Get the vector for inputs using Input.get_vector(<-,->,^,v) 
	#3 - velocity = input * move_speed 
	#4 - use move_and_slide() for player
	
	var collision: KinematicCollision2D = get_last_slide_collision()
	#Adding block movement mechanics
	if collision:
		
		var collider_node = collision.get_collider()
		
		if collider_node is RigidBody2D:
			var collider_normal : Vector2 = collision.get_normal()
			
			#applies force in the middle of the object
			collider_node.apply_central_force(-collider_normal * push_force)
			
	pass
