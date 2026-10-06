---
name: ai-project-initialization
description: Bootstraps the AI Engineering System for a new or existing Flutter project. Use only during initial setup or when re-initializing project memory.
---

# Project Initialization Skill

## When to Use
- First time the AI Engineering System enters a project
- Re-initialization after project memory is lost

## Protocol
1. Detect Flutter/Dart versions.
2. Inspect `pubspec.yaml` for dependencies.
3. Inspect `lib/` structure for architecture pattern.
4. Detect state management approach.
5. Detect reusable Core components.
6. Detect testing setup.
7. Detect existing Skills/Rules/MCPs.
8. Detect Git state.
9. **Graph check** (optional) — If Graphify is available, run `graphify extract <project-path> --code-only` to generate a structural codebase graph for rapid architecture understanding. See `ai-codebase-graph` skill.
10. Create/update `.ai/project/` documentation.
11. Create missing focused Skills.
12. Generate Bootstrap Report.

## Rules
- Do NOT modify existing code.
- Do NOT start feature development.
- Do NOT perform architectural changes.
- Preserve all existing user work.
