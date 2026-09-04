extends Node

@export var tower1 : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hud_tower_1_pressed() -> void:
	print("Tower 1 Pressed")
	var newTower = tower1.instantiate()
	newTower.position = Vector2(50,600)
	self.add_child(newTower)
