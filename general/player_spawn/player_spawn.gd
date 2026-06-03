@icon("res://general/icons/player_spawn.svg")

class_name PlayerSpawn extends Node2D


func _ready() -> void:
	
	visible = false
	await get_tree().process_frame
	
	if get_tree().get_first_node_in_group("Player"):
		print("We have a player")
		return
	print("we dont have a player")
	
	var player : Player = load("uid://j3o0gdjp3xkt").instantiate()
	get_tree().root.add_child(player)
	
	player.global_position = self.global_position
	
	pass
