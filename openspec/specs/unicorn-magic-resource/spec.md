# unicorn-magic-resource Specification

## Purpose

Defines the unicorn's magic meter: its range, how spells consume it, and
the rule that spells cannot be cast without enough magic.

## Requirements

### Requirement: Magic Meter Range
The unicorn's magic SHALL be tracked as a percentage between 0% and 100%
inclusive, SHALL start at a defined initial value when a play session
begins, and SHALL never exceed 100% or drop below 0%.

#### Scenario: Magic clamped at maximum
- **WHEN** an action would increase magic above 100%
- **THEN** the magic value is set to exactly 100%

#### Scenario: Magic clamped at minimum
- **WHEN** an action would decrease magic below 0%
- **THEN** the magic value is set to exactly 0%

### Requirement: Spell Casting Consumes Magic
Each spell (starting with the rainbow bridge) SHALL have a defined magic
cost, and successfully casting that spell SHALL deduct its cost from the
current magic value.

#### Scenario: Casting deducts the correct amount
- **WHEN** the player successfully casts the rainbow bridge spell with
  magic cost C
- **THEN** the magic meter decreases by exactly C

### Requirement: Insufficient Magic Blocks Casting
A spell SHALL NOT be cast, and no magic SHALL be deducted, if the current
magic value is less than the spell's magic cost.

#### Scenario: Attempting to cast with too little magic
- **WHEN** the player attempts to cast a spell whose cost exceeds the
  current magic value
- **THEN** the spell is not cast and the magic value is unchanged

### Requirement: Magic Meter Visibility
The current magic value SHALL be visible to the player at all times during
play as an on-screen indicator.

#### Scenario: Magic indicator reflects current value
- **WHEN** the magic value changes (increases or decreases)
- **THEN** the on-screen magic indicator updates to reflect the new value
