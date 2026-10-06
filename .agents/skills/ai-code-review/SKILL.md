---
name: ai-code-review
description: Guides code review for Waheed Flutter project changes. Use after implementing a feature, fix, or refactor to validate quality.
---

# Code Review Skill

## Review Checklist

### Correctness
- [ ] Requirements satisfied
- [ ] Correct behavior
- [ ] No regressions in existing behavior

### Architecture
- [ ] Follows feature-based structure
- [ ] Core reused where applicable
- [ ] No unnecessary architectural changes
- [ ] No new state management patterns introduced

### Clean Code
- [ ] Meaningful names
- [ ] Focused functions/widgets
- [ ] No duplicated logic
- [ ] No magic values (use AppColors, AppTextStyles)
- [ ] No dead code or unused imports

### File Size
- [ ] Files under 400-line target
- [ ] If over, extraction improves maintainability

### UI Fidelity (if applicable)
- [ ] AppColors used (no inline hex)
- [ ] AppTextStyles used where applicable
- [ ] RTL layout correct
- [ ] Figma compared (if available)

### Codebase Graph (Optional)
If a codebase graph is available (see `ai-codebase-graph` skill):
- [ ] All files importing modified components were checked for needed updates
- [ ] No unintended new coupling introduced
- [ ] Change scope is complete (no missed importers/references)

### Safety
- [ ] No secrets committed
- [ ] No unintended Core modifications
- [ ] Diff reviewed
