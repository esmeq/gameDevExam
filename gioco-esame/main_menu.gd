extends Control

const SETTINGS_SCENE_PATH = "res://settings.tscn"
const GAMEPLAY_SCENE_PATH = "res://vignette.tscn" # La scena in cui inizia il gioco

func _ready():
	CursorManager.set_cursor(CursorManager.State.MENU)

# --- MODIFICA QUI ---
func _on_start_button_pressed():
	# Controlliamo se esiste la sessione salvata
	if FileAccess.file_exists("user://session.json"):
		print("Sessione attiva trovata! Entro direttamente in partita...")
		get_tree().change_scene_to_file(GAMEPLAY_SCENE_PATH)
	else:
		print("Nessuna sessione trovata. Reindirizzamento al Login...")
		get_tree().change_scene_to_file("res://login.tscn")

func _on_settings_button_pressed() -> void:
	print("Apertura impostazioni...")
	get_tree().change_scene_to_file(SETTINGS_SCENE_PATH)

func _on_exit_button_pressed():
	# Chiude l'eseguibile del gioco in modo pulito
	get_tree().quit()
