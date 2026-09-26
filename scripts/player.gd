extends CharacterBody2D
## The player character: a girl who can walk/jump on foot, or ride her
## unicorn to jump higher and cast rainbow bridges.
##
## A single scene models both forms as an internal state machine so that
## position, velocity, and camera stay continuous across mount/dismount.

enum Form { ON_FOOT, MOUNTED }

@export_group("Movement")
@export var walk_speed: float = 220.0
@export var acceleration: float = 1600.0
@export var deceleration: float = 2000.0

@export_group("Jumping")
@export var on_foot_jump_velocity: float = -420.0
@export var mounted_jump_velocity: float = -560.0

@export_group("Rainbow Bridge")
@export var rainbow_bridge_scene: PackedScene = preload("res://scenes/RainbowBridge.tscn")
@export var rainbow_bridge_cost: float = 30.0
@export var rainbow_bridge_offset: Vector2 = Vector2(110.0, 0.0)

@onready var on_foot_shape: CollisionShape2D = $OnFootShape
@onready var mounted_shape: CollisionShape2D = $MountedShape
@onready var on_foot_visual: Node2D = $OnFootVisual
@onready var mounted_visual: Node2D = $MountedVisual

var form: Form = Form.ON_FOOT
var facing: int = 1
var move_direction: int = 0
var active_bridge: Node = null

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", 980.0)


func _ready() -> void:
	add_to_group("player")
	_apply_form()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	_apply_horizontal_movement(delta)
	move_and_slide()


func _apply_horizontal_movement(delta: float) -> void:
	var target_speed := float(move_direction) * walk_speed
	if move_direction != 0:
		facing = move_direction
		velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)


## Called every physics frame by the touch/mouse controls to set the
## desired horizontal movement direction (-1, 0, or 1).
func set_move_input(direction: int) -> void:
	move_direction = clampi(direction, -1, 1)


## Jumps if the character is currently standing on the ground. Ignored
## while airborne. Jump height depends on the current form.
func jump() -> void:
	if not is_on_floor():
		return
	velocity.y = mounted_jump_velocity if form == Form.MOUNTED else on_foot_jump_velocity


## Toggles between the on-foot and mounted forms. Has no effect while
## the character is airborne.
func toggle_mount() -> void:
	if not is_on_floor():
		return
	form = Form.MOUNTED if form == Form.ON_FOOT else Form.ON_FOOT
	_apply_form()


func _apply_form() -> void:
	var mounted := form == Form.MOUNTED
	on_foot_shape.disabled = mounted
	mounted_shape.disabled = not mounted
	on_foot_visual.visible = not mounted
	mounted_visual.visible = mounted


## Casts a rainbow bridge in front of the character. Only works while
## mounted, grounded, and with enough magic. Replaces any previously
## active bridge cast by this player.
func cast_rainbow_bridge() -> void:
	if form != Form.MOUNTED:
		return
	if not is_on_floor():
		return
	if not GameState.try_spend(rainbow_bridge_cost):
		return

	if is_instance_valid(active_bridge):
		active_bridge.queue_free()
		active_bridge = null

	var bridge: Node2D = rainbow_bridge_scene.instantiate()
	get_parent().add_child(bridge)
	bridge.global_position = global_position + Vector2(rainbow_bridge_offset.x * facing, rainbow_bridge_offset.y)
	active_bridge = bridge
