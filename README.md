# ClockWorkEngine

A lightweight game engine built from scratch in [Beef](https://www.beeflang.org/), designed around composition and a visual-scripting workflow that plays nicely with version control.

The Engine is currently in an extremely early build state, expect breaking changes to occur broadly and without warning.

## Why ClockWorkEngine?

Most engines either bolt ECS on as an afterthought or bury visual scripting behind opaque, undiffable binary/blob assets. ClockWorkEngine starts from two core problems:

1. **Composition-first entities.** Entities are built by chaining together components rather than relying on deep inheritance hierarchies. The engine is architected around ECS (Entity Component System) principles so behavior can be assembled, reused, and swapped at the component level.(NEEDS IMPLEMENTATION)

2. **A first-class Visual Scripting language, authored two ways.** Logic can be written as text/script *or* built as a VisualGraph — both are representations of the same underlying language. Because graphs are backed by a diff-friendly format, large graph changes still produce meaningful, reviewable diffs in tools like GitHub, instead of unreadable blob churn.

## Project Structure

The repository is a multi-module [Beef workspace](https://www.beeflang.org/):

| Module | Purpose |
|---|---|
| `ClockWorkEngine` | Core engine runtime — module system, windowing, rendering, ECS |
| `ClockWorkEditor` | Editor shell built on top of the engine |

## Tech Stack

- **Language:** [Beef](https://www.beeflang.org/)
- **Windowing:** SDL3
- **Rendering:** wgpu
- **Architecture:** Module-based lifecycle (`CModule` / `CModuleManager`) with dependency-ordered startup, similar in spirit to engine subsystem patterns from UE5

## Status

ClockWorkEngine is early and under active development. Current focus is on foundational systems — windowing, the rendering pipeline, and the module lifecycle — with ECS and the Visual Scripting language layered in as the core stabilizes.

## Getting Started

> This section is a work in progress — build instructions will be added as the toolchain settles.

1. Install the [Beef](https://www.beeflang.org/) toolchain / IDE.
2. Open `BeefSpace.toml` at the repository root.
3. Build and run.

## License

[MIT](https://opensource.org/license/mit)
