extends Area2D

var speed = 600.0
var direction = Vector2.ZERO

func _physics_process(delta):
	# La balle avance en ligne droite selon la direction donnée
	position += direction * speed * delta

func _on_body_entered(body):
	# Si on touche un ennemi, on le supprime (et on détruit la balle)
	if body.is_in_group("ennemis"):
		body.queue_free() # Le méchant explose
		queue_free()      # La balle disparaît
