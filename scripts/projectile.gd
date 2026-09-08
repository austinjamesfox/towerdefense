extends Area2D

var moving = true

func _process(delta: float) -> void:
	pass

func move(target:Vector2, speed):
	while moving:
		print(target)
		position.x += speed
