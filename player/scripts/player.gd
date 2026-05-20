class_name Player extends CharacterBody2D


#region ///state machine variables
var states : Array[PlayerState]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[1]
#endregion

#region // stander variables

var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
#endregion


func _ready() -> void:
	initialize_state()

func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	pass
	
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	
	
func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta
	change_state(current_state.physics_process(_delta))
	move_and_slide()
	
	
	pass
	
	
func initialize_state() -> void:
	states = []
	
	for state in $States.get_children():
		if state is PlayerState:
			states.append(state)
			state.player = self
			
	if states.size() == 0:
		return
		
		
	for state in states:
		state.init()
		
	change_state(current_state)
	current_state.enter()
	
	
	
	
func change_state(new_state : PlayerState) -> void:
	if new_state == null:
		return 
	elif new_state == current_state:
		return 
	
	if current_state:
		current_state.exit()
		
		
	states.push_front(new_state)
	current_state.enter()
	
	states.resize(3)
	
	
func update_direction() -> void:
	direction = Input.get_vector("left","right","up","down")
	pass
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
