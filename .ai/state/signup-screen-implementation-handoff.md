# Sign Up Screen — Antigravity Handoff

## Status: READY FOR UI IMPLEMENTATION

The implementation specification is complete using the full Flutter Figma-to-Code export supplied in the task. The export's visual assets are empty `Stack()` placeholders; all requested local image/SVG assets were located and their types, viewBoxes, and visible SVG contents checked. There is no need to wait for another Figma export to begin implementation. The prior Figma MCP call limit means values are **not newly or independently verified against Figma**; honor the supplied export and record the noted home-indicator discrepancy honestly.

## Read these first

1. `.ai/state/LAST-CHECKPOINT.md`
2. `.ai/project/figma-specs/SCREEN-03-SIGN-UP.md`
3. `.ai/project/figma-specs/ASSET-INVENTORY.md`
4. `.ai/project/figma-specs/DESIGN-TOKENS.md`
5. `.ai/project/figma-specs/IMPLEMENTATION-READY-BRIEF.md`
6. This handoff and `.ai/state/antigravity-sign-up-implementation-prompt.md`

## Verified local asset map

| Screen slot | Exact path | Evidence |
|---|---|---|
| Background | `assets/images/background.jpg` | Existing JPEG, 900 × 1350, 140,225 bytes; already used by Get Started/Login. Use as background; no duplicate/export. |
| Full-name icon | `assets/icons/profilee.svg` | Existing SVG, 20 × 20 viewBox, 712 bytes, gray profile mark. Use this; do not use, replace, or rename the distinct `profile.svg`. |
| Phone icon | `assets/icons/call.svg` | Existing SVG, 20 × 20, 1,908 bytes, `#939393` handset at the physical right edge. Keep 174 px country-prefix/separator/number group at left. `phone.svg` exists too but uses `#858585`; prefer `call.svg`. |
| Email icon | `assets/icons/email.svg` | Existing SVG, 20 × 20, gray envelope. |
| Password reveal states | `assets/icons/eyeoff.svg`, `assets/icons/eye.svg` | Both existing SVGs, 20 × 20, gray. |
| Google | `assets/icons/googel.svg` | Existing SVG, 17 × 17, Google colors; preserve filename. |
| Apple | `assets/icons/appel.svg` | Existing SVG, 14 × 17 black mark; use within 20 × 20 viewport; preserve filename. |
| Phone separator | Flutter line, no file | Draw 26 × 1 px in `#EAEAEA`, rotate 1.57 rad. |

Local asset existence/content is verified, but the supplied export contains blank Stack placeholders and the Figma MCP quota is exhausted; byte identity to Figma vectors is not claimed. No asset files were changed.

## Implementation constraints

- Work only in the existing auth feature and directly relevant widgets. Current relevant files: `login_screen.dart`, `get_started_screen.dart`, `auth_text_field.dart`, `social_login_button.dart`, `auth_styles.dart`, `AppImage`.
- Follow the design metrics and exact Arabic copy in `SCREEN-03-SIGN-UP.md`; sample phone/email/password strings are hints, not initial values.
- Keep existing Login widget defaults unchanged. Current `AuthTextField` is 50 px high/radius 14/padding 14; signup needs 48/radius 12/padding 16. Current `SocialLoginButton` is 50 px high, uses an 8 px gap and icon-before-label order; configure narrowly for 48 px, 4 px gap, and physical label-left/icon-right order using explicit direction or a feature-local variant.
- IBM Plex Sans Arabic is specified by the supplied export but is not registered. Use the existing Cairo fallback and preserve all other exported type metrics. Do not add fonts/packages or dependencies.
- Existing navigation is imperative. Add a Sign Up screen link from Login's existing `إنشاء حساب جديد` prompt, and make Sign Up's `تسجيل الدخول` return to the existing `LoginScreen`. Do not change the current login submit behavior or startup flow.
- Implement controller-backed fields, keyboard types/actions, focus progression, scrolling with the keyboard, independent visibility toggles, and local required/email/password-match validation. Do not impose phone parsing rules absent product requirements.
- The repository has no signup API, provider auth, loading/error convention, or successful registration destination. Leave submission/provider integrations inert pending real requirements; do not fake success, navigate Home, or add new architecture/state management/dependencies.
- Keep files within the project's 400-line target; extract small auth widgets if useful. Preserve current unrelated changes.

## Validation and known limitation

Format changed Dart files, run focused auth tests and analysis, and report results. Compare a 402 × 947 render to the supplied export metrics. A live Figma screenshot comparison is conditional on Figma access returning; none is available as a local file here. The source export positions the system bar at left=270/top=25 and rotates it 3.14 rad, while prior Figma context described a centered bar with 8 px bottom inset. Preserve both facts, flag the discrepancy, and don't claim pixel matching without a direct visual check.

Exact execution steps are in `.ai/state/antigravity-sign-up-implementation-prompt.md`.
