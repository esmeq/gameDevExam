extends Node

# Precaricamento dei cursori originali
const CURSOR_MENU_TEX = preload("res://cursore main.png")
const CURSOR_GAMEPLAY_TEX = preload("res://cursore partita.png")
const CURSOR_TARGET_TEX = preload("res://cursore nemico.png")

# Imposta qui la dimensione desiderata in pixel (es. 32x32 o 48x48)
const CURSOR_SIZE = Vector2i(32, 32)

enum State { MENU, GAMEPLAY, TARGET }

var current_state: State = State.MENU

# Texture ridimensionate
var cursor_menu: Texture2D
var cursor_gameplay: Texture2D
var cursor_target: Texture2D

func _ready():
	# Scaliamo le immagini all'avvio
	cursor_menu = _scale_texture(CURSOR_MENU_TEX, CURSOR_SIZE)
	cursor_gameplay = _scale_texture(CURSOR_GAMEPLAY_TEX, CURSOR_SIZE)
	cursor_target = _scale_texture(CURSOR_TARGET_TEX, CURSOR_SIZE)

func set_cursor(state: State):
	current_state = state
	match state:
		State.MENU:
			Input.set_custom_mouse_cursor(cursor_menu, Input.CURSOR_ARROW, Vector2(0, 0))
		State.GAMEPLAY:
			Input.set_custom_mouse_cursor(cursor_gameplay, Input.CURSOR_ARROW, Vector2(0, 0))
		State.TARGET:
			# Hotspot al centro del cursore (meta della dimensione: 16, 16)
			var center_hotspot = Vector2(CURSOR_SIZE.x / 2.0, CURSOR_SIZE.y / 2.0)
			Input.set_custom_mouse_cursor(cursor_target, Input.CURSOR_ARROW, center_hotspot)

# Funzione helper per scalare le immagini mantenendo la trasparenza
func _scale_texture(texture: Texture2D, new_size: Vector2i) -> Texture2D:
	var img = texture.get_image()
	# Usa INTERPOLATE_NEAREST per pixel art, oppure INTERPOLATE_LANCZOS per grafiche HD ad alta definizione
	img.resize(new_size.x, new_size.y, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(img)
