extends CharacterBody2D

const SPEED = 130.0 
@onready var player = get_tree().get_first_node_in_group("joueur")

func _physics_process(_delta):
	# On cherche le joueur à chaque fois s'il n'a pas été trouvé au début
	if not player:
		player = get_tree().get_first_node_in_group("joueur")
		
	if player:
		# 1. On calcule la direction vers le joueur
		var direction = (player.global_position - global_position).normalized()
		if $AnimatedSprite2D.animation != "marche" or !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play("marche")
		# 2. On applique la vitesse
		velocity = direction * SPEED
		
		# On lance l'animation de marche du méchant
		if $AnimatedSprite2D.animation != "default":
			$AnimatedSprite2D.play("default")
			
		move_and_slide()
