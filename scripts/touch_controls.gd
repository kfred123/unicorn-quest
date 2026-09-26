extends CanvasLayer
## On-screen touch/mouse control scheme for tablets: move left/right,
## jump, mount/dismount, and cast-rainbow-bridge buttons. All buttons
## work via touch or mouse (see `input_devices/pointing/emulate_touch_from_mouse`
## in project settings) and no keyboard input is required.

@export var player_path: NodePath = ^"../Player"

@onready var player: Node = get_node(player_path)

@onready var move_left_button: TouchScreenButton = $Controls/MoveLeftButton
@onready var move_right_button: TouchScreenButton = $Controls/MoveRightButton
@onready var jump_button: TouchScreenButton = $Controls/JumpButton
@onready var mount_button: TouchScreenButton = $Controls/MountButton
@onready var cast_button: TouchScreenButton = $Controls/CastButton


func _ready() -> void:
	jump_button.pressed.connect(player.jump)
	mount_button.pressed.connect(player.toggle_mount)
	cast_button.pressed.connect(player.cast_rainbow_bridge)


func _physics_process(_delta: float) -> void:
	var direction := 0
	if move_left_button.is_pressed():
		direction -= 1
	if move_right_button.is_pressed():
		direction += 1
	player.set_move_input(direction)
