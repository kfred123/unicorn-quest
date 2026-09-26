extends Area2D
## A collectible food item that refills the unicorn's magic meter when
## touched by the player, then removes itself for the rest of the play
## session (it does not respawn if the area is revisited).

@export var magic_value: float = 25.0

var collected: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if collected:
		return
	if not body.is_in_group("player"):
		return

	collected = true
	GameState.add(magic_value)
	queue_free()
