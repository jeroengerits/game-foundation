# UI

Global UI shell: root screens, HUD shells, navigation, themes.

## Rules

- Global UI is a shell + navigation layer.
- Feature-specific UI remains inside the feature folder.
- UI shell may reference features only through stable routes/contracts (e.g., screen IDs), not feature internals.
