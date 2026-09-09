extends Area2D
class_name Projectile

@export var projectileSpeed = 1000

var moving : bool = false

@onready var towerPosition : Vector2 = self.get_parent().position

var target : Vector2:
	set(value):
		target = value
		moving = true

func _process(delta: float) -> void:
	if moving:
		var speed = projectileSpeed * delta 
		move(target,speed)

func move(target:Vector2, speed):
		var positionDifference : Vector2 = target - towerPosition
		position += speed * positionDifference.normalized()


func _on_area_entered(area: Area2D) -> void:
	area.get_parent().take_damage(1)
	queue_free()
