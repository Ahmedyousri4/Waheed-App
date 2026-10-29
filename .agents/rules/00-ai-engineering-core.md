# AI Engineering Core Rules — Waheed

## Always Active

1. **Respect existing architecture** — Feature-based, Minimal profile.
2. **State management** — ValueNotifier only. Do not introduce Provider/BLoC/Riverpod without approval.
3. **Core reuse** — Check `core/widgets/`, `core/managers/`, `app/theme/` before creating new components.
4. **AppColors & AppTextStyles** — Never inline hex colors or font specs.
5. **300-line strict file target** — Maximum 300 lines of code per source file. Split large screens into cohesive, focused widgets and supporting files. Refactor immediately if a file approaches or exceeds this limit.
6. **RTL-first** — Default locale is Arabic. Test UI in RTL.
7. **No over-engineering** — No Clean Architecture, DI, or repository pattern unless explicitly approved.
8. **Approval gates** — Major architecture, state management migration, global Core changes, or destructive operations require user approval.
9. **Git safety** — No discarding changes, no blind resets. Preserve existing user changes.
10. **Evidence over claims** — Never claim tested/validated/pixel-perfect without actual evidence.
11. **Checkpoint** — Update `.ai/state/LAST-CHECKPOINT.md` after meaningful work.
12. **Token efficiency** — Use targeted inspection, not full-project scans. Reuse known context.
13. **Automatic startup for every screen request** — Whenever a screen, screenshot, Figma specification, Flutter export, or detailed screen requirements are provided:
    a. Recover project context from `.ai/state/LAST-CHECKPOINT.md`.
    b. Read the Master Engineer Workflow and `.agents/skills/ai-feature-development/SKILL.md`.
    c. Consult the Graphify graph (`graphify-out/graph.json`) and relevant project specifications.
    d. Inspect relevant feature files, routes, reusable widgets, design tokens, and assets.
    e. Use relevant configured tools and skills when available and appropriate.
    f. Determine the smallest safe implementation scope.
    g. Begin implementation directly when requirements are sufficiently clear; do not make the user repeat established rules or reconfirm known facts.
14. **Graphify is a required workflow tool** — Consult `graphify-out/graph.json` to understand dependencies, feature relationships, reusable components, and architectural boundaries. Regenerate (`graphify extract . --code-only`) only when graph is missing or materially stale. Never claim it was used if not actually inspected.
15. **Tool discovery and graceful fallback** — Verify tool availability before relying on it. If a tool or MCP (e.g. Figma quota) is unavailable, fall back to existing local specifications and artifacts. Never repeatedly retry blocked tools.
16. **Permanent quality gates** — Format (`dart format`), static analysis (`flutter analyze`), and test suite validation (`flutter test`) before considering any screen task complete.
17. **Mandatory AppImage usage** — Whenever implementing or modifying any UI displaying images, icons, or vector graphics, always use the existing `AppImage` component from `core/widgets/app_image.dart` wherever supported. Pass the filename (e.g. `'profilee.svg'`, `'background.jpg'`). Never use raw `Image.asset`, `Image.network`, `SvgPicture.asset`, or `SvgPicture.network` directly when `AppImage` supports the use case.

