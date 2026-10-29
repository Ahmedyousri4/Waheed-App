# Antigravity Brief — Get Started and Login

## Readiness

These documents provide local visual references, manually supplied Screen 01 frame
properties, and user-approved Screen 01 typography. Neither screen is fully specified. Treat
all screenshot-derived geometry as estimates and all frame/layer mapping on Login as
provisional. Manual Figma inspection is still needed for remaining layout properties,
component mappings, styles, asset-layer relationships, and interaction behavior. Do not
claim pixel-perfect fidelity from these references alone.

## Detailed documents

- [Screen 01 — Get Started](SCREEN-01-GET-STARTED.md), node `549:8382`.
- [Screen 02 — Login](SCREEN-02-LOGIN.md), node `549:8392`.
- [Asset inventory](ASSET-INVENTORY.md): verified local raster/SVG contents and dimensions.
- [Design tokens](DESIGN-TOKENS.md): manually reported values, local observations, and
  existing project tokens kept separate.
- [Screen flow](SCREEN-FLOW.md): required target flow and current app behavior.

Figma file key: `OwhGcfZwmermbcH2L8rfUD`. No Figma MCP calls were made during this continuation.

## Verified project conventions

- Feature-based Flutter project; entry is `lib/main.dart`.
- `MaterialApp.home` is `SplashScreen`; splash currently replaces itself with `HomeScreen`
  after three seconds. The target flow is Splash → Get Started → Login.
- Use imperative `Navigator` conventions; no router dependency is configured.
- Reuse `AppColors`, `AppTextStyles`, `AppImage`, and suitable existing Core widgets only
  when they match the later verified design.
- Inter and Cairo are registered in `pubspec.yaml`. Both screens now use the user-confirmed
  shared family IBM Plex Sans Arabic, which is not currently registered there. A later
  implementation task must handle this font prerequisite; this documentation update does not
  alter project configuration.
- `assets/images/`, `assets/icons/`, and `assets/lotties/` are declared asset directories.
  Exact confirmed candidate paths and their uses are in the asset inventory.
- Arabic is the app's default locale. Confirm direction, mixed Arabic/English handling, and
  Figma typography before implementation.
- Existing state conventions are `setState` for local UI state and `ValueNotifier` for
  shared app state. Provider is declared but is not the documented active pattern.

## Later implementation requirements

- Use the supplied Screen 01 frame properties as manually reported exact values, while
  retaining their provenance and confirming any ambiguity (especially what object has
  radius 44) during Figma review.
- Treat `assets/images/getstarted.png` and `assets/images/login (2).png` as reference
  screenshots, not production image layers. `assets/images/background.jpg` is a separate
  portrait photo candidate; its exact design-layer mapping and crop remain unverified.
- Use Screen 01's approved title `إطلالة تليق بك`, subtitle
  `تسوّق أو استأجر بدلتك المفضلة بخطوات بسيطة وتجربة فاخرة.`, and description
  `مجموعة حصرية من البدلات والإكسسوارات الفاخرة...` exactly as recorded. Preserve the
  description ellipsis; do not complete the text. The approved typography table is the
  source for those text metrics. The screenshot's missing shadda in the subtitle and lack of
  a visible separate Description are recorded discrepancies to resolve only as placement/
  rendering questions during Figma review.
- Use IBM Plex Sans Arabic for all Screen 01 text. The project does not currently register
  this font in `pubspec.yaml`; address that in a later authorized implementation task.
- Use exact local asset paths as found. Do not rename `appel.svg` or `googel.svg`.
- Implement only the required flow: Splash → Get Started → Login, with the `البدء الآن`
  CTA opening Login. Do not infer Login, social, forgot-password, or account-creation
  business logic from appearance alone.
- Preserve existing user changes. This analysis did not modify app source, dependencies,
  `pubspec.yaml`, or asset files.

## User-confirmed shared typography

These shared style definitions match `DESIGN-TOKENS.md` and are used by both screen specs.
Screen-specific copy and role assignments stay in the screen documents.

| Shared role/style | Family | Weight | Size | Line height | Letter spacing | Alignment | Color |
|---|---|---:|---:|---:|---:|---|---|
| Title | IBM Plex Sans Arabic | 600 (SemiBold) | 24 px | 100% | 0 | Center | `#000000` |
| Subtitle | IBM Plex Sans Arabic | 400 (Regular) | 14 px | 22.75 px | 0 | Center | `#000000` |
| Description | IBM Plex Sans Arabic | 400 (Regular) | 14 px | 100% | 0 | Right | `#939393` |
| Other text, including CTA labels | IBM Plex Sans Arabic | Role-specific values unresolved | — | — | — | — | — |

On Login, `تسجيل الدخول` uses Title and `ليس لديك حساب ؟ إنشاء حساب جديد` uses Subtitle.
All other Login text retains Login's own content and IBM Plex Sans Arabic family; metrics
remain unresolved where no shared role clearly matches. Login has no text currently assigned
to the generic Description role. See `SCREEN-02-LOGIN.md` for the element-by-element map.

## Manual visual confirmation still needed

Confirm the placement/order and Figma layer for the separate Get Started Description, exact
background layer/crop, all spacing and component geometry, role-specific metrics for text
that does not map to a shared style, Screen 02 frame dimensions and actual node hierarchy,
`FIXED`/`SCROLLS` assignments, exact colors/effects/radii, safe-area/responsive behavior, and
all interaction states/destinations. Shared typography values and the Login title/account
prompt assignments are user-confirmed; other Login element styles remain unresolved. Compare
rendered implementation with Figma before making any visual-fidelity claim.

## Screen 03 — Sign Up

- [Screen 03 — Sign Up](SCREEN-03-SIGN-UP.md), target node `549:8455`, frame `إنشاء حساب`, 402 × 947 px. Current detailed geometry is extracted from the supplied Flutter Figma-to-Code export; it has not been independently rechecked through Figma MCP.
- The local asset map is verified from existing files: background `assets/images/background.jpg`; profile `profilee.svg`; call `call.svg`; email `email.svg`; eye states `eyeoff.svg` / `eye.svg`; Google `googel.svg`; Apple `appel.svg`. See `ASSET-INVENTORY.md` for exact paths, dimensions and SVG evidence. No assets were exported or modified.
- The full screen specification and Antigravity implementation prompt are in `SCREEN-03-SIGN-UP.md` and `../../state/antigravity-sign-up-implementation-prompt.md`; the handoff is ready for UI implementation.
- Existing `AuthTextField` and `SocialLoginButton` are suitable starting points, but their default field/button height and input padding differ. Add scoped configurability or small feature-local variants while preserving Login defaults. Existing Cairo is the font fallback; IBM Plex Sans Arabic is not registered, and no font/dependency change is authorized.
- Keep registration backend, provider authentication, and successful-submit destination unresolved; wire local form input/validation and Login navigation only. The supplied export and earlier context disagree about home-indicator position; the spec records both and requires render comparison if Figma becomes available.
- Figma MCP Starter-plan limit prevented a fresh Figma comparison. Do not describe values as independently Figma-verified; compare the Antigravity render against a live Figma render if access is restored.
---

## Selection addendum - root 472:6759

Readiness: partial extraction archive; not ready for implementation. Read SELECTION-MASTER-INDEX.md, all eight SELECTION-SCREEN specifications, SCREEN-FLOW.md, DESIGN-TOKENS.md, ASSET-INVENTORY.md, COMPONENT-INVENTORY.md, and EXTRACTION-COVERAGE-REPORT.md.

Next preparation: restore Figma access; review all eight screenshots; inspect text/style/layout properties, variables, component definitions, prototypes, and exports in focused batches; map assets against local files; resolve missing legal content and deletion-state behavior. After extraction, implement only when expressly authorized, in dependency-aware order derived from verified flow, and validate incrementally against each screen. Preserve the existing feature architecture, imperative navigation, AppImage API, and 300-line source limit.