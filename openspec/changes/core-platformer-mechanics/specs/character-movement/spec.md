# Spec Delta

## Purpose

Defines the shared 2D movement physics (horizontal movement, jumping,
gravity, and ground/wall collision) that both the on-foot girl and the
mounted unicorn form use as their common base behavior.

## ADDED Requirements

### Requirement: Horizontal Movement
The player character SHALL move left or right along the ground at a
constant walk speed while a directional input is held, and SHALL stop
moving when no directional input is active.

#### Scenario: Player moves right
- **WHEN** the player holds the "move right" input
- **THEN** the character moves right at its walk speed until the input is
  released or the character is blocked by a wall

#### Scenario: Player releases movement input
- **WHEN** the player releases all directional inputs
- **THEN** the character decelerates to a stop within a short, fixed time

### Requirement: Jumping
The player character SHALL jump to a form-specific maximum height when the
jump input is pressed while the character is standing on the ground, and
SHALL NOT be able to jump again until it has landed.

#### Scenario: Jump from ground
- **WHEN** the character is on the ground and the jump input is pressed
- **THEN** the character leaves the ground and rises to its current form's
  maximum jump height before falling back down under gravity

#### Scenario: Jump input ignored while airborne
- **WHEN** the character is airborne (not touching the ground) and the
  jump input is pressed
- **THEN** the input is ignored and the character's trajectory is
  unaffected

### Requirement: Gravity and Ground Collision
The player character SHALL fall under constant gravity when not
supported by the ground, and SHALL come to rest on top of solid ground
and platform surfaces without passing through them.

#### Scenario: Falling off a ledge
- **WHEN** the character walks off the edge of a platform
- **THEN** the character falls downward under gravity until it lands on a
  solid surface below

#### Scenario: Landing on solid ground
- **WHEN** a falling character's collision shape reaches the top surface
  of solid ground
- **THEN** the character stops falling and is considered "on the ground"
