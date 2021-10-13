extends Node2D

func _ready():
	$AnimatedSprite.play()
	$ExplosionSound.play()


func _on_ExplosionSound_finished():
	queue_free()
