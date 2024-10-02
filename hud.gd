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
