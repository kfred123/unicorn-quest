# Design

## Context

Unicorn Quest is greenfield: no code or specs exist yet. This design covers
the first Godot 4.x project setup and the core movement/mount/spell/magic
loop described in `proposal.md`. See `proposal.md` for motivation; see the
capability specs under `specs/` for exact required behavior.

## Goals / Non-Goals

**Goals:**
- Establish a Godot 4.x project structure (`res://scenes`, `res://scripts`,
  `res://assets`) that later content (levels, art, story) can build on.
- Implement one `Player` entity that can be in either the "on foot" or
  "mounted" state, satisfying `character-movement`, `unicorn-mount`,
  `rainbow-bridge-spell`, and `unicorn-magic-resource`.
- Implement a touch/mouse control layer usable on tablets, satisfying
  `touch-mouse-controls`.
- Provide one minimal test level (ground, a narrow cave passage, a gap,
  and food pickups) sufficient to manually verify every spec scenario.

**Non-Goals:**
- Final art, animation, or sound — placeholder shapes/sprites are enough
  for this change.
- Additional spells beyond the rainbow bridge, save/persistence of magic
  or collected food across sessions, enemies, or a full level set. These
  are separate future changes.
- Mobile export/build pipeline (signing, store packaging) — only the
  in-editor/desktop-runnable touch input behavior is in scope here.

## Decisions

**Single Player scene with two internal states, not two separate scenes.**
The Player is one `CharacterBody2D` scene (`Player.tscn`) with a small
state machine (`on_foot` / `mounted`) driven by a script, rather than
swapping between an entirely separate girl scene and unicorn scene. This
keeps position, velocity, and camera continuity trivial across
mount/dismount (no re-parenting or state hand-off needed) and matches the
spec's requirement that mount/dismount happens "at the same position."
Alternative considered: separate `Girl.tscn` and `Unicorn.tscn` scenes
swapped at runtime — rejected because it complicates preserving physics
state and camera follow across the swap.

**Two `CollisionShape2D` children, only one enabled at a time.**
`OnFootShape` (small) and `MountedShape` (larger) are both children of the
Player; the state machine enables exactly one and disables the other on
every state change. This directly implements the differing hitbox sizes
required by `unicorn-mount` using built-in Godot collision toggling,
rather than resizing a single shape at runtime (which is error-prone for
physics engines mid-frame).

**Jump height and walk speed as per-state exported values.**
The movement script exposes `on_foot_jump_velocity` /
`mounted_jump_velocity` (and walk speed equivalents) as `@export` values
on the Player script, read according to current state. This keeps
`character-movement` (shared physics loop: gravity, `move_and_slide`,
ground checks) and `unicorn-mount` (per-form tuning) cleanly separated:
one shared movement function, parameterized by state.

**Magic as an autoloaded singleton (`GameState`).**
Magic (0–100) lives in a Godot autoload singleton so the magic meter UI,
the rainbow bridge spell (cost check + deduction), and food pickups (magic
refill) can all read/write it without a dependency on the Player node
tree. The singleton exposes `magic: float`, `try_spend(cost) -> bool`, and
`add(amount)` (clamping 0–100), and emits a `magic_changed(new_value)`
signal that the UI meter listens to. Alternative considered: storing magic
directly on the Player node — rejected because pickups and UI would need a
reference to the Player instance, adding coupling the singleton avoids.

**Rainbow bridge as a pooled, single-instance scene.**
Casting instantiates a `RainbowBridge.tscn` (a `StaticBody2D` with a
`CollisionShape2D` and a `Timer` for its duration) at the player's facing
position. The Player keeps a reference to the currently active bridge; a
new cast frees the existing one (if any) before instantiating the new one,
satisfying the "single active bridge" requirement. The bridge frees itself
when its `Timer` times out.

**Touch/mouse controls via Godot's built-in `TouchScreenButton` nodes.**
`TouchScreenButton` natively supports both touch and mouse clicks and
handles multiple simultaneous touches independently (e.g., holding "move"
while tapping "jump"), which a single custom `Control`-based button setup
would need to reimplement. Movement buttons use `is_pressed` polling each
physics frame; jump/mount/cast buttons connect their `pressed` signal
directly to Player methods. This satisfies `touch-mouse-controls` without
a third-party plugin.

**No physical keyboard fallback in this change.**
Per spec, all actions must work via touch/mouse controls alone. Keyboard
debug shortcuts may be added later for desktop development convenience,
but are out of scope to avoid implying keyboard is a supported input
method for players.

## Risks / Trade-offs

- [Two collision shapes toggled at runtime could momentarily overlap
  geometry on the mount/dismount frame, causing a small position pop] →
  Mitigate by only allowing mount/dismount while grounded (per spec) and
  keeping both shapes' bottom edges aligned so the ground contact point
  doesn't shift.
- [`TouchScreenButton` visuals need placeholder textures to be visible in
  the editor] → Use simple colored placeholder sprites for this change;
  swap for final art later without behavior changes.
- [Mobile export templates/signing are not covered here] → Desktop
  (Windows) run with mouse input is sufficient to validate all specs now;
  actual tablet/export validation is tracked as follow-up, not blocking
  this change.

## Migration Plan

Not applicable — this is the first change in a new project; there is no
prior state to migrate.
