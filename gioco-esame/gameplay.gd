extends Node2D

@onready var player = $Player
@onready var player_sprite = $Player/Sprite

# La grandezza finale del personaggio (0.3 significa 30% della grandezza originale)
# Modifica questo valore per renderlo più grande (es. 0.5) o più piccolo (es. 0.2)
const FINAL_SCALE = Vector2(0.65, 0.65) 

func _ready():
	# 1. Impostiamo il cursore di default per il gameplay
	CursorManager.set_cursor(CursorManager.State.GAMEPLAY)
	
	# 2. Prepara il personaggio per la materializzazione (invisibile e minuscolo)
	player_sprite.modulate.a = 0.0
	player_sprite.scale = Vector2(0.01, 0.01)
	
	# 3. Avvia l'animazione
	materialize_player()

func materialize_player():
	print("Materializzazione in corso...")
	var tween = create_tween()
	
	# Transizione Elastica per l'effetto di comparsa
	tween.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
	# Il personaggio cresce fino alla dimensione impostata in FINAL_SCALE
	tween.tween_property(player_sprite, "scale", FINAL_SCALE, 1.5)
	
	# Parallelamente, diventa completamente visibile
	tween.parallel().tween_property(player_sprite, "modulate:a", 1.0, 1.5)
