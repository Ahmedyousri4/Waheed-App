---
name: ai-architecture-analysis
description: Analyzes project architecture health, dependencies, coupling, and structure. Use when evaluating architecture decisions or investigating structural problems.
---

# Architecture Analysis Skill

## When to Use
- User requests an architecture review
- Structural problems are suspected
- Before proposing architectural changes
- During project health checks

## Analysis Areas

### 1. Structure Compliance
- Does `lib/` follow the feature-based structure?
- Are features self-contained (screens + widgets)?
- Does `core/` avoid importing from `features/`?
- Do `models/` avoid Flutter imports?

### 2. Dependency Rules
```
features/ → core/, models/, app/theme/
core/     → Flutter SDK only
models/   → Dart only
```
- Identify violations of these rules.
- Check for circular dependencies between features.

### 3. File Size
- Identify files exceeding the 400-line target.
- Assess whether extraction would improve maintainability.

### 4. State Management Consistency
- Is ValueNotifier + setState used consistently?
- Are there mixed patterns (Provider, BLoC, etc.)?
- Are ValueNotifier listeners properly disposed?

### 5. Core Reuse
- Are Core widgets (AppImage, AppBackButton, etc.) used where applicable?
- Are AppColors and AppTextStyles used consistently (no inline hex)?
- Is there duplicated logic that belongs in Core?

### 6. API Layer
- Is Dio usage consistent?
- Are errors handled properly?
- Is authentication applied where needed?

## Output
Produce a structured report with:
- Findings (categorized by severity: critical, warning, note)
- Affected files
- Recommended actions (with approval gates for major changes)

## Codebase Graph (Optional)

If a codebase graph is available (see `ai-codebase-graph` skill), use it to:
- Detect dependency rule violations and circular dependencies automatically
- Identify "god nodes" (highly coupled components)
- Trace transitive dependency chains
- Verify architecture boundaries

The graph supplements but does not replace manual inspection.

## Rules
- This skill is **analysis only**. Do not refactor during analysis.
- Report first. Let the user decide what to act on.
- Do not force advanced patterns (Clean Architecture, DI, etc.).
- Reference `.ai/project/ARCHITECTURE-POLICY.md` for current decisions.
