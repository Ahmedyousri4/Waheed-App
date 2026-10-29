---
name: ai-feature-development
description: Guides implementing new Flutter features within the Waheed project architecture. Use when adding a new screen, widget, or feature module.
---

# Master Engineer Screen & Feature Implementation Workflow

## 1. Automatic Startup for Every Screen Request

Whenever the user provides a screen, screenshot, Figma specification, Flutter export, or detailed screen requirements, execute this automatic sequence:

1. **Recover project context:** Read `.ai/state/LAST-CHECKPOINT.md` to confirm the exact active state and ensure no interrupted work is lost or repeated.
2. **Review canonical workflow:** Consult this skill (`ai-feature-development`) and `.agents/rules/00-ai-engineering-core.md`.
3. **Consult Graphify knowledge graph:** Inspect `graphify-out/graph.json` to understand existing dependencies, feature relationships, reusable components, navigation routes, and architectural boundaries before opening files.
4. **Targeted inspection:** Inspect only the specific feature directory, navigation routes, reusable widgets, design tokens (`app/theme/` or feature styles), assets, and existing conventions directly relevant to the target screen.
5. **Tool & MCP availability check:** Verify tool availability before relying on it (e.g. Figma MCP quotas). Use the best available project artifacts and local specifications if an external tool is blocked.
6. **Decompose and scope:** Plan the smallest safe implementation scope, decomposing UI into cohesive, focused widgets strictly under the 300-line file limit.
7. **Direct execution:** Begin implementation directly when requirements are sufficiently clear. Do not force the user to re-state established architecture rules, file-size limits, testing expectations, or previously confirmed decisions. Ask a concise question only if an unresolved decision genuinely blocks implementation.

## 2. Graphify as a Required Workflow Tool

Graphify is a mandatory structural reasoning tool for the screen implementation workflow:
- **Consult first:** Always inspect `graphify-out/graph.json` (or use Graphify MCP if configured) to trace imports, class hierarchies, references, and navigation connections.
- **Reuse existing graph:** Do not rebuild the graph if the existing `graph.json` is adequate for answering structural questions.
- **Incremental update only when needed:** If the graph is missing or materially stale (e.g. after major file additions), run `graphify extract . --code-only` to update it incrementally.
- **Integrity rule:** Never claim Graphify was used unless it was actually inspected or queried. Remember that Graphify Dart extraction provides structural relationships (imports, inheritance, references, navigation), not function-level call tracing.

## 3. Tool Discovery and Graceful Fallback

- **Verify before use:** Do not assume a tool, MCP server, or external service is functional simply because it is documented. Test availability and check for rate/quota limits.
- **Graceful degradation:** If an external tool (such as Figma MCP) is unavailable, rate-limited, or paywalled, do not repeatedly retry. Fall back immediately to existing local screen specifications (`.ai/project/figma-specs/`), design tokens, and verified local assets in `assets/`.
- **Transparency:** Document which tools were used and report any blockers honestly.

## 4. Permanent Clean-Code & Architecture Rules

- **Strict <= 300 lines per file:** Every source file (screens, widgets, styles, tests) must strictly remain at or below 300 lines of code. If a screen or widget approaches 300 lines, extract cohesive child widgets into `lib/features/<feature_name>/widgets/` or helpers into `utils/`.
- **Architectural boundaries:**
  - Feature code lives in `lib/features/<feature_name>/`.
  - Feature-specific widgets live in `lib/features/<feature_name>/widgets/`.
  - Shared global widgets live in `lib/core/widgets/`. Core NEVER imports from features.
  - Shared design tokens live in `lib/app/theme/app_colors.dart` and `app_text_styles.dart` or feature-scoped styles in `utils/`.
  - No inline hex colors or arbitrary text styles.
- **State Management:** Keep the minimal profile — `setState` for local screen state and `ValueNotifier` for cross-widget state. Do not introduce Clean Architecture, BLoC, Riverpod, or new state management packages without explicit approval.
- **Navigation:** Use imperative `Navigator.push` and `Navigator.pop`. Do not introduce declarative routing packages without explicit approval.
- **RTL-First Arabic UI:** The app is Arabic-first (`Locale('ar')`). Ensure text directions, alignment, and physical icon positions match documented specifications. Use explicit `TextDirection.ltr` for numeric, phone, or email inputs and physical icon/label pairings where needed to prevent unintended mirroring under Arabic `Directionality`.
- **Asset integrity & mandatory AppImage usage:**
  - Whenever implementing or modifying UI that displays images, icons, or vector graphics, ALWAYS use the Core `AppImage` widget (`package:waheed/core/widgets/app_image.dart`) wherever its capabilities support the use case.
  - `AppImage` automatically resolves `.svg` to `assets/icons/$image`, raster images to `assets/images/$image`, `.json` to `assets/lotties/$image`, and HTTP URLs to network images. Pass only the asset filename (e.g. `image: 'profilee.svg'`, `image: 'background.jpg'`).
  - Do NOT use `Image.asset`, `Image.network`, `SvgPicture.asset`, or `SvgPicture.network` directly when `AppImage` supports the required use case.
  - Verify local assets in `assets/icons/` and `assets/images/`. Never overwrite, rename, or duplicate existing assets without approval. Draw programmatic shapes (lines, borders) in Flutter rather than inventing missing image assets.

## 5. Step-by-Step Implementation Flow

1. **Understand & Spec:** Read screen spec in `.ai/project/figma-specs/` or task prompt. Note exact copy, layout dimensions, asset paths, and discrepancies.
2. **Decompose:** Plan files so no file exceeds 300 lines:
   - `<feature>_screen.dart`: Screen layout, scaffolding, scroll controller, state orchestration.
   - `widgets/<section>_widget.dart`: Extracted functional sections or complex inputs.
   - `utils/<feature>_styles.dart`: Scoped typography and color tokens.
3. **Form & Lifecycle Management:**
   - Always initialize and dispose controllers and focus nodes in State lifecycle.
   - Implement local input validation, error states, and prevent duplicate submission during active actions.
   - Never invent or fabricate dummy backend auth/API endpoints or success destinations; leave pending integrations cleanly isolated.
4. **Connect Navigation:** Wire explicit navigation between screens using imperative `Navigator` as confirmed by specifications.
5. **Validate (Mandatory Quality Gates):**
   - Format: `dart format` on all touched Dart files.
   - Analyze: `flutter analyze` — zero new issues allowed.
   - Test: `flutter test` on relevant feature test files. Write focused widget tests covering rendering, input validation, toggles, and navigation.
   - Line Count Check: Verify every created/modified file is <= 300 lines.
   - Diff Review: Ensure no unrelated files or user modifications were disturbed.
6. **Document:** Update `.ai/state/LAST-CHECKPOINT.md` with files created/modified, line counts, validation results, and next actions.

