extends Node
@export var coin_scene: PackedScene
@export var playtime = 30
var screensize = Vector2.ZERO
var score = 0
var time_left = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport().get_visible_rect().size
	$Player.hide()
	time_left = playtime
	$HUD.update_timer(time_left)


func spawn_coins():
	for i in 8:
		var c = coin_scene.instantiate()
		add_child(c)
		c.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))


func _on_player_pickup() -> void:
	score += 1
	$HUD.update_score(score)


func _on_game_timer_timeout() -> void:
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_hud_start_game() -> void:
	spawn_coins()
	$Player.show()
	time_left = playtime
	$GameTimer.start()


func game_over():
	$GameTimer.stop()
	# TODO, game over screen
