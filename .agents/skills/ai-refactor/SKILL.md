---
name: ai-refactor
description: Guides safe refactoring in the Waheed Flutter project. Use when reorganizing code, extracting widgets, or reducing file size.
---

# Refactor Skill

## Before Refactoring
1. Check `.ai/state/LAST-CHECKPOINT.md`.
2. Identify all files that will be affected.
3. If the refactor is large (>3 files or touches Core), request approval.

## Protocol
1. **Define goal** — What problem does this refactor solve?
2. **Graph check** (optional) — If a codebase graph is available (see `ai-codebase-graph` skill), query it to identify files that import or reference the components being refactored and check inheritance/implementation chains. Note: function-level caller identification is not available.
3. **Scope** — List files to modify.
4. **Checkpoint** — Save current state.
5. **Implement** — Preserve behavior. Extract only where extraction improves readability.
6. **Verify** — Run static analysis. Run app. Verify no behavior change.
7. **Review diff** — Confirm no unintended changes.
8. **Update state** — Update checkpoint.

## Rules
- Refactoring MUST preserve behavior (unless behavior change is explicitly requested).
- Do not refactor unrelated code.
- Do not force abstractions (no DI, no repository pattern) without approval.
- 400-line target is a guide, not a mandatory split trigger.
- If extracting widgets, place them in the feature's `widgets/` folder.
