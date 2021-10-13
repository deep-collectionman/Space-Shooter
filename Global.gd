extends Node

onready var score: int = 0
onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func random(min_number, max_number):
	rng.randomize()
	var random_number = rng.randf_range(min_number, max_number)
	return random_number
