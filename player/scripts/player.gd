class_name Player extends CharacterBody2D


const DEBUG_JUMP_INDICATAR = preload("uid://bwt382s3224l7")

#region // onready variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_ray_cast: RayCast2D = $OneWayPlatformRayCast


#endregion

#region // export variables
@export var move_speed : float = 150
#endregion

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
var gravity_multipler : float = 1.0
#endregion


func _ready() -> void:
	initialize_state()

func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	
	
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	
	
func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta * gravity_multipler
	change_state(current_state.physics_process(_delta))
	move_and_slide()
	
	
	
	
	
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
	$Label.text = current_state.name
	
	
	
	
	
func change_state(new_state : PlayerState) -> void:
	if new_state == null:
		return 
	elif new_state == current_state:
		return 
	
	if current_state:
		current_state.exit()
		
		
	states.push_front(new_state)
	current_state.enter()
	$Label.text = current_state.name
	states.resize(3)
	
	
func update_direction() -> void:
	var x_axise = Input.get_axis("left","right")
	var y_axise = Input.get_axis("up","down")
	direction = Vector2(x_axise,y_axise)
	
	
	
func add_debug_indicator(color : Color = Color.RED) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATAR.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	
	await get_tree().create_timer(3.0).timeout
	d.queue_free()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
