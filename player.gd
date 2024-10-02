extends Area2D
@export var speed = 350
var screensize = Vector2(480, 720)
var velocity = Vector2.ZERO
signal pickup


func _ready() -> void:
	position = screensize / 2


func _process(delta: float) -> void:
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * speed * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit()
