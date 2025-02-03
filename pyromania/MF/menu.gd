extends Node2D






func _on_play_r_pressed():
		get_tree().change_scene_to_file("res://LF/fl/level_test.tscn")

func _on_quit_pressed():
		get_tree().quit()
