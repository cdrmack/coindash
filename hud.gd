extends CanvasLayer
signal start_game

func update_score(value):
	$MarginContainer/Score.text = str(value)


func update_timer(value):
	$MarginContainer/Time.text = str(value)


func _on_button_pressed() -> void:
	$Message.hide()
	$StartButton.hide()
	start_game.emit()


func _on_timer_timeout() -> void:
	$Message.hide()


func show_game_over():
	$Message.text = "GAME OVER"
	$Message.show()
	$Timer.start()
	await $Timer.timeout
	$StartButton.show()
	$Message.text = "Coin Dash!"
	$Message.show() # TODO: why this is needed? otherwise Message is not displayed at all after changing it's value
