# Proposal

## Why

Unicorn Quest is a new project with no gameplay yet. We need the foundational
2D platformer loop in place — a girl character who can walk/jump on foot or
ride her unicorn, with each form unlocking different traversal (foot: fits
into caves; mounted: jumps higher and can conjure rainbow bridges) — so the
core "explore on foot, traverse mounted" gameplay loop exists and can be
built on by later content (levels, enemies, story) and playtested on a
tablet with touch input.

## What Changes

- Add a shared 2D character movement/physics foundation (walk, jump, gravity,
  ground/wall collision) used by both the on-foot girl and the mounted
  unicorn form.
- Add a mount/dismount mechanic: a dedicated button toggles between
  "on foot" (smaller hitbox, fits narrow cave openings, standard jump) and
  "mounted on unicorn" (larger hitbox, higher jump, cannot enter narrow
  openings).
- Add the unicorn's rainbow bridge spell: while mounted, the player can cast
  a temporary walkable rainbow platform to cross gaps/chasms too wide to
  jump.
- Add the unicorn magic resource: a 0–100% meter that depletes when casting
  a spell (rainbow bridge is the first spell) and blocks casting at 0%.
- Add magic food pickups: collectible items that refill the magic meter,
  placed mostly inside caves/narrow passages that are only reachable on foot.
- Add a touch/mouse control scheme sized for tablets: on-screen
  move left/right controls, a jump button, a mount/dismount button, and a
  cast-rainbow-bridge button, all usable via touch or mouse.

## Capabilities

### New Capabilities
- `character-movement`: Shared 2D movement physics (walk, jump, gravity,
  ground collision) used by both the on-foot girl and mounted unicorn forms.
- `unicorn-mount`: Mount/dismount toggle and the two resulting player forms
  (on-foot vs mounted), including their differing hitbox size, jump height,
  and cave/passage access.
- `rainbow-bridge-spell`: Casting a temporary walkable rainbow platform
  while mounted, to cross gaps/obstacles.
- `unicorn-magic-resource`: The 0–100% magic meter, its depletion on spell
  cast, and the rule that casting requires enough magic.
- `magic-food-pickups`: Collectible food items that refill the magic meter,
  spawning predominantly in cave/passage areas reachable only on foot.
- `touch-mouse-controls`: On-screen touch/mouse control scheme (move, jump,
  mount/dismount, cast) sized and laid out for tablet play.

### Modified Capabilities
(none — this is the first change in the project)

## Impact

- New Godot project structure under `res://scenes` and `res://scripts`
  (player controller, unicorn mount state machine, rainbow bridge spell,
  magic resource, food pickups, on-screen touch UI).
- No existing code/specs affected — this establishes the baseline.
