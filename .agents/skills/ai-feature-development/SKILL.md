---
name: ai-feature-development
description: Guides implementing new Flutter features within the Waheed project architecture. Use when adding a new screen, widget, or feature module.
---

# Feature Development Skill

## Before Starting
1. Read `.ai/project/ARCHITECTURE.md` — understand current structure.
2. Read `.ai/project/DESIGN-SYSTEM.md` — identify reusable components.
3. Read `.ai/project/CORE-CONFIGURATION.md` — check for existing Core widgets/managers.
4. Check `.ai/state/LAST-CHECKPOINT.md` — ensure no interrupted prior work.

## Implementation Flow
1. **Understand** — Clarify requirements. Identify affected areas.
2. **Graph check** (optional) — If a codebase graph is available (see `ai-codebase-graph` skill), query it to discover reusable components, map dependencies, and estimate change scope.
3. **Plan** — Define files to create/modify. Identify Core reuse opportunities.
4. **Inspect** — Read only the files you will touch or depend on.
5. **Implement** — Follow existing patterns (ValueNotifier, AppColors, etc.).
6. **Validate** — Run the app, verify behavior, check static analysis.
7. **Review** — Inspect diff. Confirm no unintended changes.
8. **Update state** — Update checkpoint.

## Rules
- Place new screens under `lib/features/<feature_name>/`.
- Place feature-specific widgets under `lib/features/<feature_name>/widgets/`.
- Reuse `AppColors`, `AppTextStyles`, and Core widgets.
- Do not exceed 400 lines per file. Extract when it improves clarity.
- Do not modify Core without stating the impact.
- Use imperative `Navigator.push`/`Navigator.pop` for navigation.
- Use `ValueNotifier` for shared state if needed.
- If Figma is available, use it as UI source of truth.
