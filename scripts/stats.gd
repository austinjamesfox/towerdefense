extends Node

@export var max_health : int = 100
@export var damage : int = 1

@onready var health : int = max_health:
	set = set_health

func set_health(value):
	health -= value
