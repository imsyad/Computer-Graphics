extends Node


func _ready():
	OS.window_resizable = false


func _on_Button_pressed():
	var tree_1 = get_tree()
	tree_1.change_scene("res://Scene/scene_1.tscn")


func _on_scene2_pressed():
	var tree_2 = get_tree()
	tree_2.change_scene("res://Scene/scene_2.tscn")


func _on_scene3_pressed():
	var tree_3 = get_tree()
	tree_3.change_scene("res://Scene/scene_3.tscn")
