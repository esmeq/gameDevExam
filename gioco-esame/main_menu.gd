extends Control

func _on_start_button_pressed():
	# Sostituisci il percorso con il nome esatto del file della tua UI di Login
	get_tree().change_scene_to_file("res://Login.tscn")

func _on_exit_button_pressed():
	# Chiude l'eseguibile del gioco in modo pulito
	get_tree().quit()
