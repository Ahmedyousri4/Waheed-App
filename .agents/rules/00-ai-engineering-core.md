# AI Engineering Core Rules — Waheed

## Always Active

1. **Respect existing architecture** — Feature-based, Minimal profile.
2. **State management** — ValueNotifier only. Do not introduce Provider/BLoC/Riverpod without approval.
3. **Core reuse** — Check `core/widgets/`, `core/managers/`, `app/theme/` before creating new components.
4. **AppColors & AppTextStyles** — Never inline hex colors or font specs.
5. **400-line file target** — Extract when it improves maintainability, not just to hit the number.
6. **RTL-first** — Default locale is Arabic. Test UI in RTL.
7. **No over-engineering** — No Clean Architecture, DI, or repository pattern unless explicitly approved.
8. **Approval gates** — Major architecture, state management migration, global Core changes, or destructive operations require user approval.
9. **Git safety** — No discarding changes, no blind resets. Currently no Git repo — recommend initializing one.
10. **Evidence over claims** — Never claim tested/validated/pixel-perfect without actual evidence.
11. **Checkpoint** — Update `.ai/state/LAST-CHECKPOINT.md` after meaningful work.
12. **Token efficiency** — Use targeted inspection, not full-project scans. Reuse known context.
