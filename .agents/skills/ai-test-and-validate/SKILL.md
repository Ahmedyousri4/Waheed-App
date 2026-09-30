---
name: ai-test-and-validate
description: Guides testing and validation for the Waheed Flutter project. Use when writing tests, running analysis, or validating behavior after implementation.
---

# Test & Validate Skill

## Validation Levels
Select the appropriate level based on risk and scope:

### Level 1 — Quick (low-risk, small change)
- Run `flutter analyze`
- Verify app compiles (`flutter build` or hot reload)

### Level 2 — Standard (feature, bug fix)
- Run `flutter analyze`
- Run existing tests: `flutter test`
- Manually verify affected screen(s)
- Check for regressions in related features

### Level 3 — Thorough (high-risk, refactor, Core change)
- Run `flutter analyze`
- Run all tests: `flutter test`
- Write new tests for changed behavior
- Manually verify all affected screens
- Inspect diff for unintended changes
- Verify API behavior if applicable

## Testing Guidelines
- Test depth must match risk. Do not create meaningless tests.
- Unit tests for business logic (managers, models, utilities).
- Widget tests for reusable Core widgets and complex UI components.
- Integration tests only when explicitly requested or for critical flows.

## Static Analysis
```bash
flutter analyze
```
Address errors and warnings. Informational lints are lower priority.

## What to Validate
| Change Type | Validate |
|-------------|----------|
| New screen | Renders, navigates correctly, RTL layout |
| Bug fix | Fix works, no regression, root cause addressed |
| Refactor | Behavior preserved, diff clean, tests pass |
| Core change | All consumers still work, no broken imports |
| API change | Request/response correct, errors handled |
| State change | ValueNotifier updates propagate correctly |

## Rules
- Never claim "tested" without actually running tests or analysis.
- Never skip validation for Core or cross-cutting changes.
- Record validation results in checkpoint when meaningful.
- If tests fail, investigate before marking task complete.
