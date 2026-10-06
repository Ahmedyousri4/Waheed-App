---
name: ai-core-integration
description: Guides safe creation, extension, and integration of Core components (widgets, managers, theme tokens). Use when adding to or modifying the shared core/ or app/theme/ layers.
---

# Core Integration Skill

## When to Use
- Adding a new reusable widget to `core/widgets/`
- Adding a new manager to `core/managers/`
- Extending `AppColors` or `AppTextStyles`
- Modifying existing Core components

## Before Modifying Core
1. Read `.ai/project/CORE-CONFIGURATION.md` — current inventory.
2. Read `.ai/project/DESIGN-SYSTEM.md` — existing tokens.
3. Identify ALL consumers of the component being changed.
4. **Graph check** (optional) — If a codebase graph is available (see `ai-codebase-graph` skill), use it to find all consumers and verify that Core does not import from features.
5. Assess impact scope.

## Decision Framework
When a reusable pattern is identified:

```
Is it used by 2+ features?
├── Yes → Consider adding to Core
│   ├── Simple addition (new widget/token) → Proceed, document
│   └── Modifies existing Core API → Approval gate
└── No → Keep in feature's widgets/ folder
```

## Adding a New Core Widget
1. Create in `core/widgets/<widget_name>.dart`.
2. Follow existing conventions (see AppImage, AppBackButton patterns).
3. Use `AppColors` and `AppTextStyles` — no inline values.
4. Widget must be self-contained: no feature imports.
5. Document the widget's purpose with a `///` doc comment.
6. Update `.ai/project/CORE-CONFIGURATION.md`.
7. Update `.ai/project/DESIGN-SYSTEM.md` if adding a visual component.

## Adding Theme Tokens
1. Add colors to `AppColors` in `app/theme/app_colors.dart`.
2. Add text styles to `AppTextStyles` in `app/theme/app_text_styles.dart`.
3. Follow existing naming conventions and grouping.
4. Update `.ai/project/DESIGN-SYSTEM.md`.

## Modifying Existing Core
This requires extra care:

1. List all files that import the component.
2. Verify the change is backward-compatible OR update all consumers.
3. Run `flutter analyze` after changes.
4. Test affected screens.
5. If the change is breaking or wide-reaching → **approval gate**.

## Rules
- Core never imports from `features/`.
- Core never imports from `models/` (except pure Dart types if needed).
- Do not create a new Core component when a feature-local widget suffices.
- Do not casually rename or restructure Core APIs.
- Global Core changes require awareness of impact; state it clearly.
