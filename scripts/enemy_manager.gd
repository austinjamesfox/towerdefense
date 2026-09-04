extends Node

@export var gameManager : Node
@export var enemySpawner : Node

signal allEnemiesDead(dead: bool)

var activeEnemies : int = 0:
	set(value):
		activeEnemies = clamp(value, 0, 100000000)
		if (activeEnemies == 0 && !enemySpawner.currentlySpawning):
			allEnemiesDead.emit(true)
	get:
		return activeEnemies


func _on_enemy_destroy_zone_area_entered(area: Area2D) -> void:
	enemyPathComplete(area)

func enemyPathComplete(enemy : Area2D):
	var currentEnemy = enemy.get_parent()
	var enemyDamage = currentEnemy.stats.damage
	gameManager.player_lose_health(enemyDamage)
	#removeEnemyActive(enemy)
	currentEnemy.instaDie()
	#currentEnemy.queue_free()

func addEnemyActive(enemy):
	activeEnemies += 1

func removeEnemyActive(enemy):
	activeEnemies -= 1
