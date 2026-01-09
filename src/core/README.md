# Core

Foundation layer: bootstrapping, routing, save/load, config, time/tick control, event dispatch.

## Rules

- No gameplay-flavored logic, no feature-specific rules, no content assumptions.
- Core may depend on `src/shared/` and `src/autoloads/` (interfaces/services).
- Core must not depend on `src/features/` or `src/content/`.
- Core is allowed to define cross-project interfaces and contracts.

## Typical Artifacts

- App entry / bootstrap scene
- Scene router / flow controller
- Save system and serialization layer
- Global config loader
- Tick/time authority
