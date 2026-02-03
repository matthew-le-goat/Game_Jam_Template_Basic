extends CharacterBody2D

const SPEED = 200.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _process(_delta: float) -> void:

	# 1. On récupère la direction
	var direction := Input.get_vector("ui_left", "ui_right","ui_up", "ui_down")

	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		
		# 2. Gestion des animations selon la direction horizontale
		if direction.x < 0:
			# Si on va vers la GAUCHE : animation marche2
			if sprite_2d.animation != "marche2":
				sprite_2d.play("marche2")
		else:
			# Si on va vers la DROITE (ou seulement haut/bas) : animation marche
			if sprite_2d.animation != "marche":
				sprite_2d.play("marche")
		
	else:
		# 3. Arrêt du mouvement et de l'animation
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		sprite_2d.stop()
		sprite_2d.frame = 0

	move_and_slide()
	
	


func _on_timer_timeout() -> void:
	# 1. On récupère la liste de tout ce qui est dans le Radar
	var cibles = $Radar.get_overlapping_bodies()
	
	if cibles.size() > 0:
		var cible_la_plus_proche = null
		var distance_min = 1000000.0 # Un chiffre énorme au début
		
		# 2. On cherche l'ennemi le plus proche parmi les cibles
		for corps in cibles:
			if corps.is_in_group("ennemis"):
				var dist = global_position.distance_to(corps.global_position)
				if dist < distance_min:
					distance_min = dist
					cible_la_plus_proche = corps
		
		# 3. Si on a trouvé un ennemi, on tire !
		if cible_la_plus_proche:
			tirer(cible_la_plus_proche)

func tirer(ennemi):
	# On charge la scène de la balle (vérifie bien le chemin vers ton fichier .tscn)
	var balle_scene = preload("res://balle.tscn")
	var nouvelle_balle = balle_scene.instantiate()
	
	# On l'ajoute au niveau (pas au pingouin, sinon la balle bouge avec lui)
	get_parent().add_child(nouvelle_balle)
	
	# On place la balle sur le pingouin et on lui donne la direction
	nouvelle_balle.global_position = global_position
	nouvelle_balle.direction = (ennemi.global_position - global_position).normalized()
