extends Node

@export var coin_scene: PackedScene
@export var powerup_scene: PackedScene
@export var obstacle_scene: PackedScene
@export var playtime = 30

var screensize = Vector2.ZERO
var score = 0
var time_left = 0


func _ready() -> void:
	screensize = get_viewport().get_visible_rect().size
	$Player.hide()
	time_left = playtime
	$HUD.update_timer(time_left)
	$PowerupTimer.wait_time = randf_range(5, 10)
	$PowerupTimer.start()


func spawn_obstacles():
	for i in 4:
		var o = obstacle_scene.instantiate()
		add_child(o)
		o.position = Vector2(randi_range(0, 0.8 * screensize.x), randi_range(0, 0.8 * screensize.y))


func spawn_coins():
	$LevelSound.play()
	for i in 8:
		var c = coin_scene.instantiate()
		add_child(c)
		c.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))


func _on_player_pickup(type) -> void:
	match type:
		"coin":
			$CoinSound.play()
			score += 1
			$HUD.update_score(score)
		"powerup":
			$PowerupSound.play()
			time_left += 5;
			$HUD.update_timer(time_left)


func _on_game_timer_timeout() -> void:
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


# TODO: reset player's position
func _on_hud_start_game() -> void:
	score = 0
	time_left = playtime
	$HUD.update_timer(time_left)
	$HUD.update_score(score)
	spawn_coins()
	spawn_obstacles()
	$Player.show()
	$GameTimer.start()


func game_over():
	$EndSound.play()
	$GameTimer.stop()
	get_tree().call_group("coins", "queue_free")
	get_tree().call_group("obstacles", "queue_free")
	get_tree().call_group("powerups", "queue_free")
	$HUD.show_game_over()
	$Player.hide()
	$PowerupTimer.stop()

func _on_powerup_timer_timeout() -> void:
	var p = powerup_scene.instantiate()
	add_child(p)
	p.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))


func _on_player_hurt() -> void:
	game_over()
