extends Node

@export var gameManager : Node

var activeEnemies : Array


signal allEnemiesDead

func _on_enemy_destroy_zone_area_entered(area: Area2D) -> void:
	enemyPathComplete(area)

func enemyPathComplete(enemy : Area2D):
	var currentEnemy = enemy.get_parent()
	var enemyDamage = currentEnemy.stats.damage
	gameManager.player_lose_health(enemyDamage)
	currentEnemy.queue_free()

func addEnemiesActive(enemy):
	activeEnemies.append(enemy)
	print("Added "+ str(enemy))

#create a signal in the enemyspawner that emits whenever an enemy is spawned so this script checks how many enemies (class) are in the scene
#also create a signal that emits when enemies die so it can be checked then also 
