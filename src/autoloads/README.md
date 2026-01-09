# Autoloads

Explicit singleton ownership. Singleton scripts registered in Project Settings.

## Rules

- Autoloads must be few, stable, and discoverable.
- Autoloads are allowed as composition roots / service locators, not gameplay logic buckets.
- Any global state must live here explicitly (no hidden globals elsewhere).
