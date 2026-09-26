# unicorn-mount Specification

## Purpose

Defines the mount/dismount toggle and the two resulting player forms
(on-foot girl vs. mounted unicorn), including their differing hitbox size,
jump height, and access to narrow cave passages.

## Requirements

### Requirement: Mount and Dismount Toggle
The player SHALL be able to toggle between "on foot" and "mounted on
unicorn" forms using a dedicated mount/dismount control, provided the
unicorn is present and reachable, and the toggle SHALL have no effect
while the character is airborne.

#### Scenario: Dismounting while grounded
- **WHEN** the player is mounted, standing on the ground, and activates the
  mount/dismount control
- **THEN** the player character switches to the on-foot girl form at the
  same position, and the unicorn remains nearby

#### Scenario: Mounting while grounded and near the unicorn
- **WHEN** the player is on foot, standing on the ground within reach of
  the unicorn, and activates the mount/dismount control
- **THEN** the player character switches to the mounted form at the
  unicorn's position

#### Scenario: Mount/dismount ignored while airborne
- **WHEN** the character is airborne and the player activates the
  mount/dismount control
- **THEN** the control has no effect and the character's current form is
  unchanged

### Requirement: On-Foot Form Traversal
While on foot, the player character SHALL use a smaller collision size
than the mounted form and SHALL be able to pass through narrow cave
openings and tunnels that the mounted form cannot fit through.

#### Scenario: Entering a narrow passage on foot
- **WHEN** the player, on foot, moves into a passage sized for the on-foot
  collision shape but smaller than the mounted collision shape
- **THEN** the character passes through the opening without obstruction

#### Scenario: Mounted form blocked from narrow passage
- **WHEN** the player, mounted on the unicorn, attempts to move into a
  passage sized for the on-foot form only
- **THEN** the mounted character is blocked by the passage's collision and
  cannot enter

### Requirement: Mounted Form Jump Height
While mounted on the unicorn, the player character SHALL reach a greater
maximum jump height than while on foot.

#### Scenario: Comparing jump heights
- **WHEN** the player jumps from level ground first on foot and then while
  mounted, with identical input timing
- **THEN** the mounted jump reaches a higher maximum height than the
  on-foot jump
