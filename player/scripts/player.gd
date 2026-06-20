class_name Player extends CharacterBody2D


const DEBUG_JUMP_INDICATAR = preload("uid://bwt382s3224l7")

#region // onready variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var one_way_platform_shape_cast: ShapeCast2D = $OneWayPlatformShapeCast


#endregion

#region // export variables
@export var move_speed : float = 150
@export var max_fall_velocity : float = 600.0
#endregion




#region //player stats
var hp : float = 20
var max_hp : float = 20
var dash : bool =  false
var double_jump : bool =  false
var ground_slam :  bool = false
var morph_roll : bool =  false

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
	if get_tree().get_first_node_in_group("Player") != self:
		self.queue_free()
	initialize_state()
	self.call_deferred("reparent" , get_tree().root)

func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	
	
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	
	
func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta * gravity_multipler
	velocity.y = clampf(velocity.y , -1000.0 , max_fall_velocity)
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
	var prev_direction : Vector2 = direction
	var x_axise = Input.get_axis("left","right")
	var y_axise = Input.get_axis("up","down")
	direction = Vector2(x_axise,y_axise)
	
	if prev_direction != direction:
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
	
	
	
func add_debug_indicator(color : Color = Color.RED) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATAR.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	
	await get_tree().create_timer(3.0).timeout
	d.queue_free()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
