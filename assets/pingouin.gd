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
