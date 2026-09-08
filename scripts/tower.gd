extends Node2D
class_name TowerClass

@export var projectileScene : PackedScene

@export var definedRange : float = 128
@export var attacksPerSecond : float = 1
@export var towerDamage : int = 1
@export var towerSprite : Sprite2D
@onready var tower_range: CollisionShape2D = %TowerRange
var canAttack : bool = true
var attackSpeed : float
var enemiesWithin : Array[Area2D]
@export var dragSpeed : int = 2
@export var projectileSpeed : int = 100

var is_dragging : bool = false

var isPlaced : bool = false

func _physics_process(delta):
	if is_dragging && !isPlaced:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position(), dragSpeed * delta)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if towerSprite.get_rect().has_point(to_local(event.position)):
				is_dragging = true
		else:
			if towerSprite.get_rect().has_point(to_local(event.position)):
				isPlaced = true
			is_dragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tower_range.shape.radius = definedRange
	attackSpeed = 1/attacksPerSecond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_attack(delta)

func _attack(delta):
	if canAttack && !isEmpty(enemiesWithin):
		canAttack = false
		fireProjectile(delta)
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

func fireProjectile(delta):
	var projectile = projectileScene.instantiate()
	self.add_child(projectile)
	projectile.move(Vector2(10,10), projectileSpeed, delta)
	#print(projectile.position)
	#projectile.position = self.position
	#print(projectile.position)
	
