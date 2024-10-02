extends Node
@export var coin_scene: PackedScene
var screensize = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	spawn_coins()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func spawn_coins():
	for i in 8:
		var c = coin_scene.instantiate()
		add_child(c)
		c.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))
