extends CanvasLayer
## On-screen HUD that displays the unicorn's magic meter, updating
## immediately whenever GameState.magic changes.

@onready var magic_bar: ProgressBar = $MarginContainer/VBoxContainer/MagicBar
@onready var magic_label: Label = $MarginContainer/VBoxContainer/MagicLabel


func _ready() -> void:
	GameState.magic_changed.connect(_on_magic_changed)
	_on_magic_changed(GameState.magic)


func _on_magic_changed(new_value: float) -> void:
	magic_bar.value = new_value
	magic_label.text = "Magie: %d%%" % roundi(new_value)
