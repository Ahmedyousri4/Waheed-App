---
name: ai-bug-fix
description: Guides root-cause bug fixing in the Waheed Flutter project. Use when a bug is reported or unexpected behavior is found.
---

# Bug Fix Skill

## Protocol
1. **Understand** — What is expected? What actually happens?
2. **Reproduce** — Identify the exact scenario and affected screen/widget.
3. **Graph check** (optional) — If a codebase graph is available (see `ai-codebase-graph` skill), query imports/references of the suspected component to assess which files may be affected. Note: function-level call tracing is not available.
4. **Locate** — Trace to the specific file(s) and line(s).
5. **Root cause** — Identify WHY the bug occurs, not just WHERE.
6. **Fix** — Apply the minimal correct fix.
7. **Test** — Verify the fix. Check for regressions.
8. **Review** — Inspect the diff. Ensure no collateral damage.
9. **Update state** — Update checkpoint if meaningful.

## Rules
- Do NOT patch symptoms. Find root causes.
- Do NOT refactor unrelated code during a bug fix.
- Preserve existing behavior in all areas unrelated to the bug.
- If the fix touches Core, state the impact clearly.
- If the fix is risky or wide-reaching, request approval.
