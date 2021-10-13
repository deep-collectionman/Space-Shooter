extends Area2D

export (PackedScene) var Explosion
export (PackedScene) var EnemyShoot

var speed
var can_shoot

func _ready():
	$AnimatedSprite.play()
	$ShootTimer.start()
	speed = GLOBAL.random(32, 64)
	can_shoot = speed < 48
	
func _physics_process(delta):
	position.y += speed * delta
	
func death_enemy():
	queue_free()
	explosion_ctrl()
	
func explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $ExplosionSpawn.global_position
	get_tree().call_group("level", "add_child", explosion)
	
func shoot_ctrl():
	var shoot = EnemyShoot.instance() 
	shoot.shooter = self
	shoot.global_position = $ShootSpawn.global_position
	get_tree().call_group("level", "add_child", shoot)
	
func _on_Enemy_body_entered(body):
	if body.is_in_group("player"):
		death_enemy()
		body.death_player()

func _on_Enemy_area_entered(area):
	if area.is_in_group("shoot"):
		death_enemy()
		GLOBAL.score += 10

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_ShootTimer_timeout():
	if can_shoot:
		shoot_ctrl()
	
	$ShootTimer.wait_time = 1.0
	$ShootTimer.start()
