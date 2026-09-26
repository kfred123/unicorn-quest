# Spec Delta

## Purpose

Defines the on-screen touch/mouse control scheme (movement, jump,
mount/dismount, cast) that lets children play the game on a tablet using
touch, or on desktop using a mouse, without requiring a keyboard.

## ADDED Requirements

### Requirement: On-Screen Movement Controls
The game SHALL present on-screen controls for moving left and right that
respond to both touch input and mouse input, and that are large enough to
be easily tapped by a child on a tablet screen.

#### Scenario: Touch input moves the character
- **WHEN** the player touches and holds the on-screen "move right" control
- **THEN** the character moves right for as long as the control is held,
  and stops when released

#### Scenario: Mouse input moves the character
- **WHEN** the player presses and holds the on-screen "move left" control
  with a mouse
- **THEN** the character moves left for as long as the mouse button is
  held on that control, and stops when released

### Requirement: On-Screen Jump, Mount/Dismount, and Cast Buttons
The game SHALL present a dedicated on-screen jump button, a dedicated
mount/dismount button, and a dedicated cast-rainbow-bridge button, each of
which responds to a single tap (touch) or click (mouse) and triggers its
associated action immediately.

#### Scenario: Tapping the jump button
- **WHEN** the player taps the on-screen jump button while the character
  is on the ground
- **THEN** the character jumps, following the jumping behavior defined for
  its current form

#### Scenario: Tapping the mount/dismount button
- **WHEN** the player taps the on-screen mount/dismount button
- **THEN** the mount/dismount toggle is triggered as if the corresponding
  input action fired

#### Scenario: Tapping the cast button
- **WHEN** the player taps the on-screen cast button while mounted,
  grounded, and with sufficient magic
- **THEN** the rainbow bridge casting behavior is triggered

### Requirement: No Keyboard Required
All actions available to the player (movement, jump, mount/dismount, cast)
SHALL be fully operable using only touch or mouse input on the on-screen
controls, without requiring a physical keyboard.

#### Scenario: Completing a level with touch only
- **WHEN** a player uses only the on-screen touch controls throughout a
  play session
- **THEN** the player is able to perform every available action (move,
  jump, mount/dismount, cast) without needing keyboard input
