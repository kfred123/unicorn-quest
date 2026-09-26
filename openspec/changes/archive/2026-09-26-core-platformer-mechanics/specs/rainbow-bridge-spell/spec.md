# Spec Delta

## Purpose

Defines how the mounted unicorn casts a temporary rainbow bridge that the
player can walk across to cross gaps and obstacles too wide to jump.

## ADDED Requirements

### Requirement: Cast Rainbow Bridge While Mounted
The player SHALL be able to cast a rainbow bridge only while mounted on
the unicorn, standing on the ground, and having enough magic available,
by activating the cast control.

#### Scenario: Successful cast
- **WHEN** the player is mounted, grounded, has at least the magic cost of
  the rainbow bridge available, and activates the cast control
- **THEN** a walkable rainbow platform appears extending from the
  character's current position in the direction the character is facing,
  and the magic cost is deducted from the magic meter

#### Scenario: Cast blocked while on foot
- **WHEN** the player is on foot (not mounted) and activates the cast
  control
- **THEN** no rainbow bridge is created and no magic is deducted

#### Scenario: Cast blocked with insufficient magic
- **WHEN** the player is mounted and grounded but has less magic than the
  rainbow bridge's cost, and activates the cast control
- **THEN** no rainbow bridge is created and no magic is deducted

### Requirement: Rainbow Bridge Walkable Surface
A cast rainbow bridge SHALL act as solid, walkable ground for the player
character (on foot or mounted) and any other physics-affected entities for
its configured duration, after which it SHALL disappear.

#### Scenario: Walking across an active bridge
- **WHEN** a rainbow bridge is active and the player character walks onto
  it
- **THEN** the character is supported by the bridge as if it were solid
  ground and does not fall through

#### Scenario: Bridge expires
- **WHEN** a rainbow bridge's configured duration elapses
- **THEN** the bridge disappears, and any character still standing on it
  is no longer supported and falls if there is no ground beneath

### Requirement: Single Active Bridge
Casting a new rainbow bridge while a previous one is still active SHALL
remove the previous bridge before creating the new one.

#### Scenario: Recasting replaces the old bridge
- **WHEN** the player casts a rainbow bridge while an earlier bridge they
  created is still active
- **THEN** the earlier bridge is removed and the new bridge is created in
  its place
