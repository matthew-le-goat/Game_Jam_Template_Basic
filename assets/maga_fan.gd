extends CharacterBody2D

const SPEED = 150.0 
@onready var player = get_tree().get_first_node_in_group("joueur")

func _physics_process(_delta):
	if not player:
		player = get_tree().get_first_node_in_group("joueur")
		
	if player:
		# 1. On calcule la direction vers le joueur
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		
		# 2. Gestion des animations selon la direction
		if direction.x < 0:
			# Il va vers la GAUCHE : on active marche2
			if $AnimatedSprite2D.animation != "marche2":
				$AnimatedSprite2D.play("marche2")
		else:
			# Il va vers la DROITE : on active marche (ou ton anim par défaut)
			if $AnimatedSprite2D.animation != "marche":
				$AnimatedSprite2D.play("marche")

		move_and_slide()
