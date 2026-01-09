# Shared

Reusable building blocks: utilities, widgets, shared shaders/materials, helpers.

## Rule of Promotion

- If used by more than one feature → `shared/`
- Otherwise → keep feature-local

## Rules

- `shared/` must not depend on any specific feature.
- `shared/` may define small, stable primitives and helpers, but must not become an alternate `core/`.
