extends StaticBody2D
## A temporary walkable platform cast by the mounted unicorn to cross
## gaps. Frees itself automatically once its duration elapses.

@export var duration: float = 5.0

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.wait_time = duration
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _on_timer_timeout() -> void:
	queue_free()
