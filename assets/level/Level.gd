extends Node2D

export (PackedScene) var Enemy

func _ready():
	$BackgroundMusic.play()
	$EnemyTimer.start()
	randomize()

func _physics_process(delta):
	apply_scroll(get_node("Background"), 8, delta)
	apply_scroll(get_node("Cloud01"), 24, delta)
	apply_scroll(get_node("Cloud02"), 36, delta)
	
func apply_scroll(node: ParallaxBackground, velocity: int, delta: float):
	node.scroll_base_offset += Vector2(0, 1) * velocity * delta

func _on_EnemyTimer_timeout():
	get_node("EnemyPath/EnemySpawn").set_offset(randi())
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = get_node("EnemyPath/EnemySpawn").position
	$EnemyTimer.wait_time = GLOBAL.random(0.5, 1.5)
	$EnemyTimer.start()

func _on_HUD_game_over():
	$BackgroundMusic.stop()
