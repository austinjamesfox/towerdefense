extends Node2D

@export var definedRange : float = 128
@export var attacksPerSecond : float = 1
@export var towerDamage : int = 1
@export var towerSprite : Sprite2D
@onready var tower_range: CollisionShape2D = %TowerRange
var canAttack : bool = true
var attackSpeed : float
var enemiesWithin : Array[Area2D]

#var is_dragging : bool = false

#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#if towerSprite.get_rect().has_point(to_local(event.position)):
				#print("Click Down")
		#else:
			#print("Click Up")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tower_range.shape.radius = definedRange
	attackSpeed = 1/attacksPerSecond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_attack()

func _attack():
	if canAttack && !isEmpty(enemiesWithin):
		canAttack = false
		enemiesWithin[0].get_parent().take_damage(towerDamage)
		await get_tree().create_timer(attackSpeed).timeout
		canAttack = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	enemiesWithin.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	enemiesWithin.erase(area)

func isEmpty(array : Array):
	if array.size() == 0:
		return true
	else:
		return false
