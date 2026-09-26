# Unicorn Quest 🦄

Ein 2D Jump'n'Run für Kinder: Ein Mädchen reitet auf einem Einhorn durch
eine bunte Welt. Per Knopfdruck kann sie absteigen, um kleine Höhlen und
enge Gänge zu erkunden, oder aufsteigen, um höher zu springen und mit
Einhorn-Magie Regenbögen zu erschaffen, über die sie größere Schluchten
überqueren kann.

## Spielidee

- **Zu Fuß**: kleinere Kollisionsform, passt durch enge Höhlengänge,
  normale Sprunghöhe, keine Zauber.
- **Auf dem Einhorn**: größere Kollisionsform, höherer Sprung, kann
  Regenbögen als begehbare Brücken zaubern.
- **Einhorn-Magie**: eine Ressource (0–100 %), die pro Zauber verbraucht
  wird. Aufgeladen wird sie nur durch Futter, das meist in Höhlen und
  engen Gängen versteckt ist — nur zu Fuß erreichbar.
- **Steuerung**: reine Touch-/Maus-Bedienung (Bewegen, Springen,
  Aufsitzen/Absteigen, Zaubern) für den Einsatz auf Tablets.

## Tech-Stack

- **Engine**: [Godot 4.x](https://godotengine.org/) (GDScript)
- **Zielplattform**: Tablet (Touch), zusätzlich Desktop (Maus)

## Spec-driven Development mit OpenSpec

Dieses Projekt wird spec-driven mit [OpenSpec](https://github.com/Fission-AI/OpenSpec)
entwickelt. Bevor Code geschrieben wird, entstehen Planungsartefakte unter
`openspec/`:

```
openspec/
  config.yaml          # Projektkontext für die KI-Workflows
  specs/                # aktueller, "lebender" Stand aller Capabilities
  changes/              # in Arbeit befindliche/archivierte Change-Proposals
    <change-name>/
      proposal.md        # Warum & Was
      design.md           # Wie (technische Entscheidungen)
      tasks.md            # Umsetzungs-Checkliste
      specs/<capability>/spec.md   # Verhaltens-Spezifikation (Delta)
```

Workflow (als GitHub-Copilot-Slash-Commands unter `.github/prompts/` verfügbar):

1. `/opsx-propose` – neue Änderung vorschlagen (Proposal + Specs + Design + Tasks)
2. `/opsx-apply` – die Change anhand der Tasks umsetzen
3. `/opsx-archive` – abgeschlossene Change archivieren und Haupt-Specs aktualisieren

### Aktueller Stand

Die erste Change **`core-platformer-mechanics`** (Bewegung, Aufsitzen/
Absteigen, Regenbogen-Zauber, Magie-Ressource, Futter-Pickups,
Touch-/Maus-Steuerung) ist vollständig geplant und validiert unter
[`openspec/changes/core-platformer-mechanics`](openspec/changes/core-platformer-mechanics).
Als Nächstes: `/opsx-apply` ausführen, um sie im Godot-Projekt umzusetzen.
