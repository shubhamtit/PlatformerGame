class_name PlayerStateJunp extends PlayerState

@export var jump_velocity : float = 450.0

func init() -> void:
	pass
	
func enter() -> void:
	player.add_debug_indicator(Color.GREEN)
	player.velocity.y -= jump_velocity
	pass
	
func exit() -> void:
	
	player.add_debug_indicator(Color.YELLOW)
	pass
	
func handle_input(_event : InputEvent) -> PlayerState:
	if _event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state
	
	
func process(_delta : float) -> PlayerState:
	
	return next_state
	
func physics_process(_delta : float) -> PlayerState:
	#if player.is_on_floor():
		#return idle // this is not working in good manner
	if player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
