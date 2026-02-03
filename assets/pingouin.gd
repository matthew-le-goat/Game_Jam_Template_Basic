extends CharacterBody2D


const SPEED = 200.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _process(delta: float) -> void:

	# get direction
	var direction := Input.get_vector("ui_left", "ui_right","ui_up", "ui_down")

	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		
		if sprite_2d.animation != "marche" or !sprite_2d.is_playing():
			sprite_2d.play("marche")
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		sprite_2d.stop()
		sprite_2d.frame = 0

	move_and_slide()
