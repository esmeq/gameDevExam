extends CharacterBody2D

# 1. Le 6 Texture per i settori della scena
@export var tex_center: Texture2D    # Zona morta (mouse vicino/sopra al personaggio)
@export var tex_up: Texture2D        # Cono Nero (Centro in alto)
@export var tex_up_left: Texture2D   # Cono Rosso SX (Up Sinistra)
@export var tex_up_right: Texture2D  # Cono Rosso DX (Up Destra)
@export var tex_left: Texture2D      # Fuori dal cono rosso a Sinistra
@export var tex_right: Texture2D     # Fuori dal cono rosso a Destra

# 2. Parametri di controllo
@export var deadzone_radius: float = 50.0  # Raggio della zona morta centrale

# Angoli di separazione dei coni (in gradi)
# Il centro in alto è a -90°. 
# Il cono nero copre da (-90° - 15°) a (-90° + 15°), cioè un'ampiezza di 30°
@export var black_cone_half_angle: float = 15.0  

# I coni rossi coprono ulteriori 50° a sinistra e a destra del cono nero
@export var red_cone_width: float = 50.0        

@onready var sprite = $Sprite 

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var diff = mouse_pos - global_position
	
	# 1. Controllo della Zona Morta
	if diff.length() < deadzone_radius:
		sprite.texture = tex_center
		return

	# 2. Calcolo dell'angolo in gradi (-180° a +180°)
	var angle_deg = rad_to_deg(diff.angle())
	
	# Soglie di angolo calcolate a partire dal punto in alto (-90°)
	var up_black_left = -90.0 - black_cone_half_angle               # -105°
	var up_black_right = -90.0 + black_cone_half_angle              # -75°
	var red_left_bound = up_black_left - red_cone_width             # -155°
	var red_right_bound = up_black_right + red_cone_width           # -25°

	# 3. Assegnazione dei settori in base al disegno
	if angle_deg >= up_black_left and angle_deg <= up_black_right:
		# dentro al CONO NERO (Centro in alto)
		sprite.texture = tex_up
		
	elif angle_deg >= red_left_bound and angle_deg < up_black_left:
		# dentro al CONO ROSSO SINISTRA (Up SX)
		sprite.texture = tex_up_left
		
	elif angle_deg > up_black_right and angle_deg <= red_right_bound:
		# dentro al CONO ROSSO DESTRA (Up DX)
		sprite.texture = tex_up_right
		
	elif angle_deg > red_right_bound and angle_deg < 90.0:
		# FUORI DAL CONO ROSSO a DESTRA
		sprite.texture = tex_right
		
	else:
		# FUORI DAL CONO ROSSO a SINISTRA (tutto il restante lato sinistro)
		sprite.texture = tex_left
