# Tasks

## 1. Godot Project Setup

- [ ] 1.1 Create the Godot 4.x project (`project.godot`) with folders
      `res://scenes`, `res://scripts`, `res://assets`, `res://scenes/levels`
      and verify the project opens in the Godot editor with no import
      errors.
- [ ] 1.2 Configure project display/input settings for a tablet-friendly
      viewport (stretch mode, touch emulation enabled for desktop testing)
      and verify the test level runs in the editor at the configured
      resolution with touch emulation active.

## 2. Character Movement (shared physics)

- [ ] 2.1 Create `Player.tscn` as a `CharacterBody2D` with `OnFootShape`
      and `MountedShape` `CollisionShape2D` children, plus a
      `player.gd` script exposing `on_foot_jump_velocity`,
      `mounted_jump_velocity`, and walk-speed `@export` values, and verify
      the scene instances in a test level without script errors.
- [ ] 2.2 Implement horizontal movement (accelerate on input, decelerate
      to stop on release) and verify by manual test: holding move
      left/right moves the character at walk speed, releasing input stops
      it within a short, fixed time (`character-movement` scenarios).
- [ ] 2.3 Implement gravity, ground detection (`is_on_floor()`), and jump
      using `move_and_slide`, reading the jump velocity for the current
      state, and verify by manual test: character falls off ledges, lands
      on solid ground, jumps only when grounded, and ignores jump input
      while airborne (`character-movement` scenarios).

## 3. Unicorn Mount/Dismount

- [ ] 3.1 Add an `on_foot` / `mounted` state field to `player.gd` with
      only `OnFootShape` or `MountedShape` enabled per state, and a
      mount/dismount method that toggles state only when grounded, and
      verify by manual test: toggling mid-air has no effect, toggling
      while grounded switches the enabled collision shape
      (`unicorn-mount` scenarios).
- [ ] 3.2 Build a test level cave passage sized to fit `OnFootShape` but
      block `MountedShape`, and verify by manual test: on-foot form passes
      through, mounted form is blocked (`unicorn-mount` scenarios).
- [ ] 3.3 Confirm mounted jump velocity is greater than on-foot jump
      velocity in the exported values, and verify by manual test:
      identical jump input reaches a visibly higher apex while mounted
      than on foot (`unicorn-mount` scenario "Comparing jump heights").

## 4. Unicorn Magic Resource

- [ ] 4.1 Create a `GameState` autoload singleton with a `magic: float`
      property (initialized to a defined starting value), a
      `try_spend(cost: float) -> bool` method, an `add(amount: float)`
      method (both clamping 0–100), and a `magic_changed(new_value)`
      signal, and verify with a quick script-console check that spending
      more than the current value returns `false` and leaves magic
      unchanged, while spending an affordable amount deducts it exactly
      (`unicorn-magic-resource` scenarios).
- [ ] 4.2 Add an on-screen magic meter UI element connected to
      `GameState.magic_changed`, and verify by manual test: the displayed
      meter updates immediately whenever magic increases or decreases.

## 5. Rainbow Bridge Spell

- [ ] 5.1 Create `RainbowBridge.tscn` (`StaticBody2D` +
      `CollisionShape2D` + `Timer`) that frees itself when its `Timer`
      times out, and verify by manual test: an instanced bridge disappears
      automatically after its configured duration.
- [ ] 5.2 Implement a cast method on `player.gd` that only casts when
      mounted, grounded, and `GameState.try_spend(cost)` succeeds,
      instantiating `RainbowBridge.tscn` at the player's facing position,
      and verify by manual test: casting while on foot or with
      insufficient magic creates no bridge and deducts no magic; casting
      while mounted with enough magic creates a bridge and deducts the
      cost (`rainbow-bridge-spell` scenarios).
- [ ] 5.3 Track the currently active bridge on the Player and free it
      before instantiating a new one on recast, and verify by manual
      test: casting a second bridge removes the first before the new one
      appears (`rainbow-bridge-spell` scenario "Recasting replaces the old
      bridge").
- [ ] 5.4 Build a test-level gap wide enough to require a rainbow bridge
      to cross, and verify by manual test: the character can walk across
      an active bridge spanning the gap without falling through.

## 6. Magic Food Pickups

- [ ] 6.1 Create a `FoodPickup.tscn` (`Area2D` + `CollisionShape2D` +
      exported `magic_value`) that, on `body_entered` from the Player,
      calls `GameState.add(magic_value)` and removes itself, tracking
      collected state for the current play session only, and verify by
      manual test: collecting a pickup increases the magic meter (clamped
      at 100%) and the pickup does not reappear if the area is revisited
      (`magic-food-pickups` scenarios).
- [ ] 6.2 Place at least one `FoodPickup` inside the cave passage from
      task 3.2 (not reachable while mounted), and verify by manual test:
      the pickup is only collectible by entering the passage on foot
      (`magic-food-pickups` scenario "Food inside a cave-only passage").

## 7. Touch/Mouse Controls

- [ ] 7.1 Build an on-screen control `CanvasLayer` with `TouchScreenButton`
      nodes for move-left, move-right, jump, mount/dismount, and cast,
      sized for tablet touch targets, and verify the layer renders over
      the test level in the editor's touch-emulated desktop run.
- [ ] 7.2 Wire move-left/move-right buttons to be polled each physics
      frame by `player.gd` and wire jump/mount/cast buttons' `pressed`
      signals directly to their respective Player methods, and verify by
      manual test: every action (move, jump, mount/dismount, cast) is
      fully operable using only mouse clicks on the on-screen controls,
      with no keyboard input (`touch-mouse-controls` scenarios).

## 8. Integration Verification

- [ ] 8.1 Manually play through the full test level on foot and mounted
      (enter the cave, collect food, dismount/mount, cross the gap with a
      rainbow bridge) using only the on-screen touch/mouse controls, and
      verify every scenario listed across the six capability specs passes
      without errors in the Godot output console.
