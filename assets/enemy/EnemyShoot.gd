extends Area2D

var shooter

const SPEED = 100

func _ready():
	shooter.can_shoot = false
	$AnimatedSprite.play()
	$ShootTimer.start()
	
func _physics_process(delta):
	position.y += SPEED * delta
	
func _on_Shoot_area_entered(area):
	if area.is_in_group("player"):
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	if is_instance_valid(shooter):
		shooter.can_shoot = true
	
	queue_free()

func _on_ShootTimer_timeout():
	if is_instance_valid(shooter):
		shooter.can_shoot = true
	
	$ShootTimer.wait_time = 1.5
	$ShootTimer.start()
