# Systems

Long-lived runtime systems: simulation loops, AI directors, turn systems, state machines, managers that outlive scenes.

## Rules

- Systems must be feature-agnostic or depend only on feature contracts (interfaces), not feature implementations.
- Systems must not own content. Systems operate on data provided to them.
- Systems must be explicit about lifecycle/ownership and stable over time.

## Forbidden

- Systems grabbing nodes by scene paths or feature-specific node names.
- Systems directly instantiating feature scenes unless routed via a `core/` router/factory contract.
