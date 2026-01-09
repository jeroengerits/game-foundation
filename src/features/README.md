# Features

Primary scaling axis for isolated feature modules.

Each folder is one isolated feature/domain, owning its scenes, scripts, resources, and local assets.

## Rules

- A feature must be usable as a "module": it should be possible to mount/unmount without breaking unrelated features.
- Feature → Feature dependency is forbidden unless routed through `shared/` or `core/` contracts.
- Feature-local assets stay with the feature. Do not promote to `assets/` unless truly global.
- Feature-specific UI lives inside the feature.

## Forbidden

- Reaching into another feature's internals (scripts, scenes, resources).
- "Utility dumping" inside a feature that becomes shared usage: move it to `shared/`.
