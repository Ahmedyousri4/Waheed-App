---
name: ai-bug-fix
description: Guides root-cause bug fixing in the Waheed Flutter project. Use when a bug is reported or unexpected behavior is found.
---

# Bug Fix Skill

## Protocol
1. **Understand** — What is expected? What actually happens?
2. **Reproduce** — Identify the exact scenario and affected screen/widget.
3. **Locate** — Trace to the specific file(s) and line(s).
4. **Root cause** — Identify WHY the bug occurs, not just WHERE.
5. **Fix** — Apply the minimal correct fix.
6. **Test** — Verify the fix. Check for regressions.
7. **Review** — Inspect the diff. Ensure no collateral damage.
8. **Update state** — Update checkpoint if meaningful.

## Rules
- Do NOT patch symptoms. Find root causes.
- Do NOT refactor unrelated code during a bug fix.
- Preserve existing behavior in all areas unrelated to the bug.
- If the fix touches Core, state the impact clearly.
- If the fix is risky or wide-reaching, request approval.
