extends Area2D
var screensize = Vector2(480, 720)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".position = screensize / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
