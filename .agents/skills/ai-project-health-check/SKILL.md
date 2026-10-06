---
name: ai-project-health-check
description: Evaluates overall project health across architecture, code quality, testing, dependencies, and documentation. Use when requested or periodically for maintenance.
---

# Project Health Check Skill

## When to Use
- User explicitly requests a health check
- Before a major milestone or release
- After extended development without review
- When project complexity concerns arise

## Health Check Areas

### 1. Architecture
- Feature-based structure consistency
- Dependency rule compliance (core ↛ features)
- File size distribution (400-line target)
- Identify misplaced files

### 2. Code Quality
- Static analysis results (`flutter analyze`)
- Unused imports and dead code
- Duplicated logic across features
- Magic values (inline colors, hardcoded strings)
- Inconsistent patterns

### 3. Core Reuse
- AppColors/AppTextStyles adoption (vs inline values)
- Core widget usage (vs duplicated implementations)
- Manager consistency (ValueNotifier pattern)

### 4. Dependencies
- Unused dependencies in `pubspec.yaml`
- Outdated packages
- Conflicting or redundant packages

### 5. Testing
- Test coverage assessment
- Test quality (meaningful vs trivial)
- Missing tests for critical logic

### 6. API & Data
- Dio usage consistency
- Error handling coverage
- Serialization patterns

### 7. UI Consistency
- Consistent use of design tokens
- RTL compliance
- Asset integrity (referenced assets exist)

### 8. Git & Project State
- Clean working tree
- Meaningful commit history
- `.ai/` documentation up to date

### 9. Documentation
- `.ai/project/` files current and accurate
- Architecture docs match actual code
- Known issues documented

## Output Format
Produce a health report:
- **Score** per category (healthy / needs attention / critical)
- **Findings** with file references
- **Recommendations** (prioritized)
- No automatic refactoring — report only

### 10. Codebase Graph (Optional)
If a codebase graph is available (see `ai-codebase-graph` skill):
- Use graph to identify high-coupling hotspots (highly connected nodes)
- Use graph `imports` links to verify dependency rule compliance
- Use graph `inherits` links to map class hierarchy depth
- Note: dead-code / unused-component detection is NOT supported by the graph alone

## Rules
- This is a **read-only analysis**. Do not modify code.
- Report findings. Let the user prioritize actions.
- Do not trigger large refactors from a health check.
- Reference `.ai/project/ARCHITECTURE-POLICY.md` for what is intentional vs problematic.
