@icon("res://assets/gamesystem/icons/input_hints.svg")
class_name InputHints extends Node2D

const HINT_MAP : Dictionary = {
	"keyboard" : {
		"interact" : 12,
		"attack" : 10,
		"jump" : 9,
		"dash" : 11,
		"up" : 13,
	}
}

var controller_type : String = "keyboard"

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	visible = false
	Messages.input_hint_change.connect(_on_hint_changed)
	pass
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventKey:
		controller_type = "keyboard"
	elif event is InputEventJoypadButton:
		get_controller_type(event.device)
		
		

func _on_hint_changed(hint : String) -> void:
	if hint == "":
		visible = false
	else:
		visible = true
		sprite_2d.frame = HINT_MAP[controller_type].get(hint)
		
	
func get_controller_type(device_id : int) -> void:
	var n : String = Input.get_joy_name(device_id).to_lower()
	
	if "xbox" in n:
		controller_type = "xbox"
	elif "playstation" in n or "ps" in n:
		controller_type = "playstation"
	elif "nintendo" in n:
		controller_type = "nintendo"
	else:
		controller_type = "unknown"
		
	set_process_input(false)
	
	
	
	
	
	
	
	
	
	
