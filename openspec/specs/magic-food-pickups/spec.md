# magic-food-pickups Specification

## Purpose

Defines collectible food pickups that refill the unicorn's magic meter,
placed predominantly in cave/passage areas that only the on-foot form can
reach.

## Requirements

### Requirement: Collecting Food Refills Magic
When the player character (in either form) touches a food pickup, the
pickup SHALL be consumed and the unicorn's magic value SHALL increase by
the pickup's defined magic value, up to the 100% maximum.

#### Scenario: Collecting a food item
- **WHEN** the player character's collision overlaps an uncollected food
  pickup
- **THEN** the pickup is removed from the level and the magic value
  increases by the pickup's magic value, clamped to 100%

#### Scenario: Collecting food at full magic
- **WHEN** the player collects a food pickup while magic is already at
  100%
- **THEN** the pickup is removed from the level and the magic value
  remains at 100%

### Requirement: Food Placement in Cave Areas
Level content SHALL place the majority of food pickups inside cave or
narrow-passage areas that are only accessible in the on-foot form, so that
replenishing magic requires dismounting to explore.

#### Scenario: Food inside a cave-only passage
- **WHEN** a level is authored with a narrow cave passage reachable only
  on foot
- **THEN** that passage contains at least one food pickup that is not
  otherwise reachable while mounted

### Requirement: Food Pickups Do Not Respawn Within a Play Session
A collected food pickup SHALL remain collected (not reappear) for the
remainder of the current play session.

#### Scenario: Revisiting a cleared passage
- **WHEN** the player returns to a passage after collecting its food
  pickup earlier in the same play session
- **THEN** the pickup does not reappear
