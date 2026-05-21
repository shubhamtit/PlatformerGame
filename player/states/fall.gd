class_name PlayerStateFall extends PlayerState

@export var coyote_time : float = 0.124
@export var fall_gravity_multiplier : float = 1.165
@export var jump_buffer_timer : float = 0.2

var coyote_timer : float = 0 
var buffer_timer : float  = 0


func init() -> void:
	pass
	
func enter() -> void:
	player.gravity_multipler = fall_gravity_multiplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass
	
func exit() -> void:
	player.gravity_multipler = 1.0
	pass
	
func handle_input(_event : InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if coyote_timer > 0:
			return jump
		buffer_timer = jump_buffer_timer
	return next_state
	
	
func process(_delta : float) -> PlayerState:
	coyote_timer -= _delta
	buffer_timer -= _delta
	return next_state
	
func physics_process(_delta : float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator(Color.RED)
		if buffer_timer > 0:
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
