extends Node
## Autoload singleton that holds the unicorn's magic resource (0-100%).
##
## The magic value can be spent by spells (try_spend) and refilled by
## food pickups (add). It is always clamped to the 0-100 range and
## broadcasts every change via the `magic_changed` signal so any UI or
## gameplay node can react without holding a reference to the Player.

signal magic_changed(new_value: float)

const MIN_MAGIC: float = 0.0
const MAX_MAGIC: float = 100.0

## Starting magic percentage when a play session begins.
@export var starting_magic: float = 50.0

var magic: float = 0.0

func _ready() -> void:
	magic = clampf(starting_magic, MIN_MAGIC, MAX_MAGIC)


## Attempts to spend `cost` magic. Returns true and deducts the cost if
## enough magic is available, otherwise returns false and leaves magic
## unchanged.
func try_spend(cost: float) -> bool:
	if cost < 0.0:
		return false
	if magic < cost:
		return false
	_set_magic(magic - cost)
	return true


## Adds `amount` magic (e.g. from a food pickup), clamped to 100%.
func add(amount: float) -> void:
	if amount <= 0.0:
		return
	_set_magic(magic + amount)


func _set_magic(new_value: float) -> void:
	var clamped := clampf(new_value, MIN_MAGIC, MAX_MAGIC)
	if is_equal_approx(clamped, magic):
		return
	magic = clamped
	magic_changed.emit(magic)
