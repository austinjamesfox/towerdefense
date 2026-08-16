extends Node

@export var gameManager : Node

func _on_enemy_destroy_zone_area_entered(area: Area2D) -> void:
	enemyPathComplete(area)

func enemyPathComplete(enemy : Area2D):
	var currentEnemy = enemy.get_parent()
	var enemyDamage = currentEnemy.stats.damage
	gameManager.player_lose_health(enemyDamage)
	currentEnemy.queue_free()
