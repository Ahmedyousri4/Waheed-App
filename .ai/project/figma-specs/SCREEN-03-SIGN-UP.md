# Screen 03 — Sign Up (إنشاء حساب)

## Sources and evidence labels

- **Figma-to-Code extracted:** dimensions, copy, layout, colors, typography, shapes, and offsets in this specification are taken from the complete Flutter export supplied with the task for Figma node `549:8455` (file `OwhGcfZwmermbcH2L8rfUD`). They are not newly queried or independently verified against Figma.
- **Existing local asset verified:** files named below were inspected at their exact paths; SVG viewBox/type and content were checked. The export represents the visual icon slots as empty `Stack()` placeholders, so local assets are mapped by existing file content and the task's required use, not by vectors embedded in the supplied export.
- **Existing project convention:** current auth screens use feature-based `lib/features/auth/`, Cairo fallback type, `Navigator`, `AuthTextField`, `SocialLoginButton`, and SVG assets. Current auth code does not provide signup, registration API, provider auth, or a reusable signup validator.
- **Inferred / unresolved:** behaviors that the source project and supplied export do not establish are identified below; no API or success route is assumed.
- The Figma MCP Starter-plan call limit was reached in the preceding turn. No new Figma calls were made for this handoff.

## Frame and layer structure (Figma-to-Code extracted)

```text
Root frame — 402 × 947
├─ Clip anti-aliased; white; 44 px radius
├─ Full-frame background treatment — 402 × 947, black at 70% opacity
│  ├─ Background photo (existing local image specified below)
│  └─ White signup sheet — x=0, y=201, 402 × 746, top radii 32 px
│     └─ Scrollable content — x=16, y=24, width 370, declared height 586
│        ├─ Centered heading group — title, account prompt; gap 4
│        ├─ Form and CTA column — gap 24 between fields group and CTA
│        │  ├─ Full name
│        │  ├─ Phone
│        │  ├─ Email
│        │  ├─ Password
│        │  ├─ Password confirmation
│        │  └─ Create account button
│        └─ Social block — gap 16
│           ├─ Divider row — height 17
│           └─ Google and Apple buttons
└─ Bottom system area — x=0, y=914, 402 × 33, white
   └─ Black rounded bar — export positions at left=270, top=25, 139 × 5, rotated 3.14 rad
```

The full-frame container clips with anti-aliasing. The sheet clips with anti-aliasing and has only top-left/top-right 32 px radii. It is a fixed-position panel with a scrollable content region in the export; do not hard-code the form controls as non-scrollable. Content starts 16 px from the sheet's left and 24 px from its top, has width 370, and is centered horizontally. The content column has 16 px gaps between its heading, form/CTA, and social sections.

**Home-indicator discrepancy to preserve:** the supplied Flutter export says `left: 270`, `top: 25`, width 139, height 5, rotated 3.14. The earlier Figma design-context representation in this session instead described a horizontally centered bar with an 8 px bottom inset. These sources disagree. Use the supplied export as the requested primary source, but visually check this area against the Figma render if access returns; do not silently replace one measurement with the other.

## Top-to-bottom screen specification

### 1. Background and outer frame

- Frame 402 × 947; white surface; 44 px outer radius; anti-aliased clip.
- Use the existing `assets/images/background.jpg` as the full-frame background image (`BoxFit.cover`, positioned to fill), behind a full-frame black overlay at 70% opacity. The supplied export contains the overlay container but omits the image widget; using this existing photo is an explicit task requirement and the existing Auth screens already use it.
- Sheet and system area render above the image/overlay. The sheet is opaque white.

### 2. Signup sheet and content

- Sheet x=0, y=201, width 402, height 746; white; top corner radii 32; clipped.
- Content x=16, y=24 relative to sheet, width 370, declared height 586. Column uses start alignment and 16 px spacing.
- Heading block centered, width 370; vertical gap 4 px.
  - Title: `إنشاء حساب`; IBM Plex Sans Arabic, 24 px, weight 600, black, centered. Export does not specify line height or letter spacing for this title.
  - Account prompt: exact rich text `لديك حساب بالفعل؟ ` followed by `تسجيل الدخول`. Both IBM Plex Sans Arabic, 14 px, line height factor 1.63 (22.82 px). First span regular/400 and black; link span medium/500 and `#314158`. Center aligned. Treat `تسجيل الدخول` as a link to the existing Login screen.

### 3. Form fields

The form is a full-width column (370 px) with 8 px gaps between field blocks. Each block places its label above its input with an 8 px gap. Labels occupy width 370, are right aligned, use IBM Plex Sans Arabic Regular 14 px, line height factor 1.63 (22.82 px), black. Inputs are 370 × 48 px, white, border 1 px `#EAEAEA`, radius 12, padding 16 px horizontal / 8 px vertical. Placeholder/sample text is IBM Plex Sans Arabic Regular 14 px, `#929292`, normal line height unless otherwise specified. Implement editable fields; strings shown in the export are visual hint/sample content and must not be initial controller values.

1. **Full name** — label `الاسم بالكامل`; hint `اكتب اسمك الكامل`; 20 × 20 profile mark at the physical right, with a 4 px gap from the hint. Use `assets/icons/profilee.svg` (not `profile.svg`).
2. **Phone** — label `رقم الهاتف`; the export's visual sample is `+20    ` plus a vertical 26 px separator, then `102233558`; the 20 × 20 call mark is at the physical right edge and the 174 px display group is at the left. Inner group order is country prefix, separator, phone digits, with 8 px gaps; separator is rotated 1.57 rad and has a 1 px `#EAEAEA` stroke. The shown number is not prefilled. Build editable phone input; country prefix UI can be displayed as designed, but country picker/number parsing behavior is unresolved.
3. **Email** — label `البريد الإلكتروني`; visual hint `Name@example.com`; email SVG 20 × 20 at the physical right with 4 px gap. Hint is not a prefilled value. Use LTR input direction for email.
4. **Password** — label `كلمة المرور`; visual mask `••••••••` is not a prefilled password. Secure input with an independently controlled visibility toggle; use `eyeoff.svg` while hidden and `eye.svg` while visible. 20 × 20 icon at physical left; text aligned right.
5. **Password confirmation** — label `تأكيد كلمة المرور`; `@1234567@` in the export is a visual sample only, never prefill it. Secure input and independent visibility toggle with the same two SVG states; 20 × 20 icon at physical left; text aligned right.

Set explicit row text directions where needed so Arabic labels/input text stay RTL, email stays LTR, and physical icon sides match the export. The export's child order alone may mirror under the app's Arabic `Directionality`; confirm layout in a render.

### 4. Create account button

- Width 370, height 56, black fill, radius 16, clipped.
- Padding 8 px horizontal / 16 px vertical; centered label `إنشاء حساب` in white, IBM Plex Sans Arabic Medium/500, 14 px. Export does not specify label line height.
- Shadow: color `#1E000000` (export `0x1E000000`), blur radius 8, offset `(0, 2)`, spread 0.
- On tap, run local form validation only. No registration API, successful destination, or loading/error convention is established in current code; do not fake account creation or navigate to Home. Keep network loading/error integration unresolved until a real auth service is specified.

### 5. Social divider and provider buttons

- Social block width 370, column spacing 16.
- Divider row height 17. Caption exactly `أو تـــــــابــع بواسطة`, IBM Plex Sans Arabic Regular/400, 11.5 px, line height factor 1.50 (17.25 px), color `#929292`. Two 1 px `#EAEAEA` lines flank it with 12 px gaps; lines share remaining width equally.
- Provider row centered, two equal-width expanded buttons, 12 px gap. Preserve the export's physical ordering: text on the left and provider mark on the right, with a 4 px gap; use explicit LTR direction for the inner text/icon row to prevent the Arabic app direction from mirroring it.
- Each button: 48 px high, white, 1 px `#EAEAEA` border, radius 14, padding 16 px horizontal / 8 px vertical. Label and icon gap 4 px.
- Google: text `Google`, IBM Plex Sans Arabic Regular/400 13 px, line height factor 1.50 (19.5 px), `#0A0A0A`, centered; `assets/icons/googel.svg`, 17 × 17.
- Apple: text `Apple`, IBM Plex Sans Arabic Regular/400 13 px, black, centered; `assets/icons/appel.svg` in the exported 20 × 20 viewport (SVG intrinsic viewBox 14 × 17).
- Keep the visible controls. Current Login screen's Google/Apple callbacks are empty and there is no provider auth integration; do not invent provider behavior or claim authentication succeeds. Keep callbacks inert until product/auth configuration is defined.

### 6. Bottom system area

- White rectangle x=0, y=914, 402 × 33.
- Exported system bar is black, radius 100, 139 × 5, positioned at left=270/top=25 inside this area and rotated 3.14 rad. This is clipped by the 402 px root at the right edge in the literal export; see the measurement discrepancy above and compare to the source render when available.

## Exact text and evidence

All user-facing text in the export is listed above. It specifies IBM Plex Sans Arabic. The Flutter export gives exact weights/sizes for every text role; line-height factors are explicit only for the prompt, field labels, divider, and Google label. It does not set tracking, paragraph spacing, or explicit `TextDirection`; don't fill those from other screen tokens. Use Cairo only as the existing project fallback while IBM Plex Sans Arabic is unavailable, without changing the exported metrics.

## Local assets — verified mapping

See `ASSET-INVENTORY.md` for the full file evidence. All listed files exist locally and have been inspected. Paths below are relative to the project root; `SvgPicture.asset` paths include the `assets/icons/` prefix.

| Visual slot | Exact local path | Local evidence / mapping |
|---|---|---|
| Full-frame photo | `assets/images/background.jpg` | JPEG, 900 × 1350, 140,225 bytes; existing photo already used by Get Started/Login. Use as signup background; do not copy/rename. |
| Full name | `assets/icons/profilee.svg` | SVG, 20 × 20 viewBox, gray `#939393` profile outline. This is the requested new asset and differs from `profile.svg`; use it here. Preserve `profile.svg`. |
| Phone | `assets/icons/call.svg` | SVG, 20 × 20, gray `#939393` handset outline. Suitable for this field. `phone.svg` also exists but its stroke is `#858585`; use `call.svg` to match the other auth icon color. |
| Phone separator | Flutter-drawn line | No image required: 26 × 1 px `#EAEAEA` rule rotated 1.57 rad, matching export. |
| Email | `assets/icons/email.svg` | SVG, 20 × 20 viewBox; envelope paths `#939393`. |
| Password hidden / visible | `assets/icons/eyeoff.svg`, `assets/icons/eye.svg` | Both SVG, 20 × 20 viewBox; gray `#939393` strokes. |
| Google | `assets/icons/googel.svg` | SVG, 17 × 17 viewBox; multicolor Google mark. Keep existing spelling. |
| Apple | `assets/icons/appel.svg` | SVG, 14 × 17 viewBox; black Apple mark. Preserve intrinsic dimensions and center in 20 × 20 slot. |

These assets are verified local files. Because the supplied Flutter export leaves icon child stacks empty and no fresh Figma fetch was made, local existence/content is verified, but exact byte-for-byte mapping to node `549:8455` is **not independently verified**. No assets were exported, fabricated, or modified for this task.

## Existing project components and conventions

- Auth feature files: `lib/features/auth/login_screen.dart`, `get_started_screen.dart`, `widgets/auth_text_field.dart`, `widgets/social_login_button.dart`, `utils/auth_styles.dart`.
- `AuthTextField` currently renders 50 px height, 14 px radius and 14 px horizontal padding; signup requires 48/12/16. Reuse only after adding narrowly configurable values that preserve Login's current defaults, or create a small signup-specific variant. It supports controllers, keyboard types, text direction, icon slots, and obscuring.
- `SocialLoginButton` currently uses 50 px height, 14 px radius, 8 px gap, and icon-before-label widget order. Configure/narrowly extend it for 48 px and 4 px gap; preserve Login defaults and render label physically left/icon right as in the supplied export using explicit `TextDirection` or a feature-local variant.
- Existing styles are in `AuthStyles`; it uses Cairo, registered in `pubspec.yaml`. IBM Plex Sans Arabic is absent from registered fonts. Do not add font packages/files without approval; use Cairo fallback and exported sizing/weight/alignment/color in local screen styles.
- `AppImage` resolves icon filenames under `assets/icons/`; direct `SvgPicture.asset('assets/icons/...')` is also used in auth code. Assets directories are already declared in `pubspec.yaml`.
- Existing navigation is imperative `Navigator`. `LoginScreen` currently has an inert account prompt and its login submit navigates to `HomeScreen` without real authentication. There is no Signup screen or registration service. Make the signup prompt return to the existing Login screen and make the Login prompt's `إنشاء حساب جديد` span open this screen so it is reachable; do not alter login submit semantics or invent a signup-success destination.

## User-requested implementation behavior (not extracted from the visual export)

- Implement editable controllers for name, phone, email, password, and confirmation; dispose controllers. Use appropriate keyboard types/actions, move focus with Next/Done, and let the sheet scroll when the keyboard reduces available height. Preserve scroll and bottom system area without obscuring the focused field.
- Both password visibility buttons toggle only their own field and swap the exact local SVG states.
- Use local form validation for required fields, a basic email validity check, and password/confirmation equality. This is a task requirement, not a Figma-extracted rule or an existing Auth convention. Do not impose phone length/country parsing rules not established by the product. Use existing `AppColors.error`/theme conventions for errors where suitable; no signup-specific validation appearance is specified by the export.
- There is no signup API, auth state, or loading/error pattern in current project auth code. Do not show a fake success, navigate to Home, or call nonexistent provider integrations. Keep registration submission and provider outcomes unresolved/inert pending product/backend integration; do not fabricate authentication.
- Link navigation to Login is required by the screen copy and requested behavior; use the existing `LoginScreen` class and imperative navigation convention, not a guessed route name.
- Figma prototype destinations, focus/error/loading/disabled designs, country picker behavior, accessibility labels, responsive breakpoints, and behavior outside 402 × 947 remain unresolved. No design screenshot file accompanies the code export in the workspace; visual comparison against a live Figma render is conditional on access returning.

## Implementation validation checklist

- [ ] Render at 402 × 947 and compare exact outer frame, photo crop/70% overlay, sheet position/radii, content offsets, and bottom system area. Record the home-indicator discrepancy.
- [ ] Confirm all five editable fields, order, hint-only sample strings, keyboard types/actions, scroll/focus behavior, and controller disposal.
- [ ] Confirm 48 px input geometry, borders/radii/padding, CTA shadow, divider lines, and 48 px provider buttons.
- [ ] Confirm physical RTL/LTR icon/text positions and that `profilee.svg`, `call.svg`, `email.svg`, `eyeoff.svg`, `eye.svg`, `googel.svg`, and `appel.svg` load from the listed exact paths.
- [ ] Confirm Login/Create Account links use the existing LoginScreen and SignupScreen without changing unrelated login or app-start navigation.
- [ ] Verify local validation and independent password visibility toggles; leave real auth/provider success behavior unresolved.
- [ ] Run formatter, focused auth tests, and analyzer as requested in the Antigravity prompt; report any baseline/new findings honestly.
