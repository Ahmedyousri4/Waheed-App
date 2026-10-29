# Antigravity Task — Implement Waheed Sign Up Screen

Implement **Screen 03 — Sign Up / إنشاء حساب** in the existing Waheed Flutter project.

## Read first

Read these files in order:

1. `.ai/state/LAST-CHECKPOINT.md`
2. `.ai/state/signup-screen-implementation-handoff.md`
3. `.ai/project/figma-specs/SCREEN-03-SIGN-UP.md`
4. `.ai/project/figma-specs/ASSET-INVENTORY.md`
5. `.ai/project/figma-specs/DESIGN-TOKENS.md`
6. `.ai/project/figma-specs/IMPLEMENTATION-READY-BRIEF.md`

The supplied Flutter Figma-to-Code export was already extracted into the screen specification. Do not repeat Figma extraction or make repeated Figma MCP calls. No fresh Figma verification is claimed because the Starter-plan call limit was reached. Do not perform a full repository audit.

## Scope

Implement the signup UI in the existing `lib/features/auth/` structure. Inspect only current Auth screens/widgets and the shared widgets/assets directly needed for this screen. Reuse `AuthTextField`, `SocialLoginButton`, `AuthStyles`, and `AppImage` where they can match the documented layout. Their current input/button sizing differs from the export; add narrowly scoped configuration or a small feature-local widget while preserving existing Login behavior. Keep each source file at or below the 400-line target where practical.

Preserve existing architecture and imperative `Navigator` conventions. Do not add Clean Architecture, Bloc, new state-management packages, dependencies, fonts, or broad Core changes without explicit approval. Use the current Cairo font fallback because IBM Plex Sans Arabic is not registered; preserve the supplied export's explicit size, weight, line height, color, and alignment metrics.

## Exact design and assets

Treat `.ai/project/figma-specs/SCREEN-03-SIGN-UP.md` as the detailed implementation contract. Key geometry: frame 402 × 947, radius 44; black overlay 70%; white sheet y=201, 402 × 746, top radius 32; content x=16/y=24/width=370; five 48 px fields with 16 px horizontal padding, `#EAEAEA` 1 px border, radius 12; CTA 370 × 56, black, radius 16 and specified shadow; divider and two 48 px social buttons with documented metrics. Match the exact Arabic copy, field order, and 4/8/12/16/24 px gaps from the spec. Use explicit text directions so Arabic is RTL, email/phone digits are usable LTR, and icons remain on the intended physical sides.

Use only these verified local assets at these exact paths:

- Background: `assets/images/background.jpg` (use as full-frame cover image beneath the 70% black overlay; do not copy or rename).
- Name/profile: `assets/icons/profilee.svg` (20 × 20). This is distinct from `assets/icons/profile.svg`; use `profilee.svg` for the Sign Up name field and leave `profile.svg` untouched.
- Phone: `assets/icons/call.svg` (20 × 20, gray, at the physical right edge). Keep the 174 px country-prefix/separator/number group at the left. `assets/icons/phone.svg` also exists but has a darker stroke; use `call.svg`.
- Email: `assets/icons/email.svg`.
- Hidden/visible password states: `assets/icons/eyeoff.svg` and `assets/icons/eye.svg`.
- Social marks: `assets/icons/googel.svg` (Google) and `assets/icons/appel.svg` (Apple). Preserve these filenames and SVG intrinsic dimensions.
- Draw the 26 × 1 px `#EAEAEA` phone separator as a Flutter line rotated 1.57 rad; it is not a missing asset.

The local assets have been inspected. The supplied code export leaves visual SVG stacks empty, so exact byte matching against Figma vectors is not claimed. Do not download, fabricate, rename, replace, or substitute assets. Keep provider labels physically on the left and icons on the right as in the export; use explicit LTR direction for those inner rows so app RTL does not mirror them. Keep profile/email icons physically right and password icons physically left; use explicit row direction as necessary.

## Real input and behavior

- Implement controller-backed editable name, phone, email, password, and confirmation inputs; dispose controllers.
- Do not initialize controllers with the example strings in the export (`+20`, `102233558`, `Name@example.com`, bullets, or `@1234567@`). They are visual hints/sample values only.
- Use appropriate keyboard types/actions, focus progression, and scroll adjustment when the keyboard opens. Keep email and phone number entry LTR while labels/form layout remain RTL.
- Implement independently toggled secure state for both password fields, swapping `eyeoff.svg` / `eye.svg`.
- Provide local required-field validation, basic email syntax validation, and password/confirmation matching. Do not invent country-code parsing or phone-length rules. Use existing project error styling where suitable.
- Make the `تسجيل الدخول` link navigate back to the existing `LoginScreen`. Make the current Login screen's `إنشاء حساب جديد` prompt/link open this Sign Up screen so it is reachable; retain existing Login copy/style and current login submit behavior.
- Keep the `إنشاء حساب` button and Google/Apple controls visible. There is no signup API, OAuth/provider integration, registration success route, or existing loading/error convention. Do not fake successful registration, navigate to Home, or show fabricated provider results. Keep those integrations inert until real product/auth behavior is provided; note the limitation in your report.
- Do not change the app startup flow or unrelated navigation.

## Design discrepancy to report

The supplied Flutter export places the system indicator at `left=270, top=25`, size 139 × 5, rotated 3.14 rad inside the 402 × 33 bottom area. Prior Figma context described a centered indicator with an 8 px bottom inset. Do not silently choose a different measurement. Follow the supplied export for implementation and compare to a Figma render if access returns; report which geometry the rendered screen uses and the unresolved source discrepancy.

## Validation

1. Format every changed Dart file.
2. Run focused auth tests and Flutter analysis; add or update focused widget tests for field rendering, password toggles, validation, and Login/Sign Up navigation as project conventions support.
3. Render at 402 × 947 and compare against the geometry/copy/styles in the handoff. If live Figma access is available, compare the screenshot directly; otherwise state that a live Figma comparison was unavailable.
4. Report exact changed files, tests/analyzer results (including pre-existing findings), missing/uncertain behavior, and all visual differences. Do not claim pixel fidelity without a direct comparison.

Do not edit the Figma source. Preserve unrelated user changes. Do not reset Git or overwrite unrelated files.
