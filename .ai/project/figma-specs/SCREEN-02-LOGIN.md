# Screen 02 — Login (تسجيل الدخول)

## Sources and confidence

- Target Figma node: `549:8392` (manually supplied). Figma MCP was not called.
- Local visual reference: [`assets/images/login (2).png`](../../../assets/images/login%20(2).png),
  confirmed PNG, `402 × 874` px. It is a composed Login screen reference. Raster dimensions
  are exact file properties, not independently confirmed Figma frame dimensions.
- Layer/frame names and `FIXED` / `SCROLLS` annotations below are user-supplied notes.
  Screenshot-derived groupings and approximate positions are explicitly provisional.

## Shared typography confirmed by the user

IBM Plex Sans Arabic is the confirmed family for **all text on this screen**. The following
shared styles are user-confirmed and match the Screen 01 definitions in
`DESIGN-TOKENS.md`:

| Login text element | Exact Login text | Applied shared style | Confirmed values |
|---|---|---|---|
| Screen title | `تسجيل الدخول` | Title | IBM Plex Sans Arabic; 600 SemiBold; 24 px; line height 100%; letter spacing 0; centered; `#000000` |
| Account prompt below title | `ليس لديك حساب ؟ إنشاء حساب جديد` | Subtitle | IBM Plex Sans Arabic; 400 Regular; 14 px; line height 22.75 px; letter spacing 0; centered; `#000000` |
| Email label | `البريد الالكتروني` | No shared role match | Family IBM Plex Sans Arabic; remaining typography unresolved |
| Email hint | `Name@example.com` | No shared role match | Family IBM Plex Sans Arabic; remaining typography unresolved |
| Password label | `كلمة المرور` | No shared role match | Family IBM Plex Sans Arabic; remaining typography unresolved |
| Password hint | `كلمة المرور` | No shared role match | Family IBM Plex Sans Arabic; remaining typography unresolved |
| Forgot-password text | `هل نسيت كلمة المرور ؟` | No shared role match | Family IBM Plex Sans Arabic; remaining typography unresolved |
| Primary button label | `تسجيل الدخول` | No shared role match | Family IBM Plex Sans Arabic; remaining typography unresolved |
| Divider caption | `أو تابع بواسطة` | No shared role match | Family IBM Plex Sans Arabic; remaining typography unresolved |
| Provider labels | `Google`, `Apple` | No shared role match | Family IBM Plex Sans Arabic per the all-text instruction; remaining typography unresolved |

No visible Login text is clearly a separate generic Description role, so the shared
Description style is not assigned to a field label, hint, link, CTA, or divider by guess.
All text strings above retain the wording already documented for Login; no Screen 01 copy
is used on this screen. The screenshot's English email hint and provider names appear LTR,
but their layout direction remains screenshot evidence rather than a confirmed Figma text
property.

## Visible composition from the local reference

Top to bottom, as visible in the image:

1. Narrow top strip of a portrait photograph, darkened by the foreground panel/background
   treatment (about 42 px high in this screenshot; estimate).
2. Large white foreground panel with rounded upper corners, beginning near y=42 and filling
   the rest of the image (position is screenshot-derived estimate).
3. Centered title `تسجيل الدخول`.
4. Centered account prompt `ليس لديك حساب ؟ إنشاء حساب جديد`.
5. Right-aligned label `البريد الالكتروني`.
6. Rounded email input showing `Name@example.com` and a small outlined envelope at its
   right edge.
7. Right-aligned label `كلمة المرور`.
8. Rounded password input showing hint `كلمة المرور` and a gray slashed-eye icon at its
   left edge.
9. Right-aligned text `هل نسيت كلمة المرور ؟`.
10. Wide black rounded button with white label `تسجيل الدخول`.
11. Thin horizontal divider segments with centered text `أو تابع بواسطة`.
12. Two outlined rounded social buttons: `Google` with colored Google G, then `Apple` with a
    black Apple mark. In the image Google is left, Apple right.
13. Black horizontal system home-indicator mark at the bottom.

The layout is Arabic-first/RTL for the form labels and copy. English email hint and provider
names remain LTR. Exact text direction configuration and mixed-direction behavior are not
known from a static raster.

## Provisional layer hierarchy

The following is a visual grouping proposal from the screenshot, **not a verified mapping of
Figma node IDs to roles or parents**. The names alone do not establish component meaning or
nesting. The supplied order is preserved here as received.

| Supplied layer/frame name | Provisional interpretation | Confidence |
|---|---|---|
| `Frame 1410125757` | Possible screen/root frame | Unverified; name only |
| `Frame 1410125768` | Unknown frame/group | Unverified |
| `Frame 1410125767` | Unknown frame/group | Unverified |
| `Frame 1410125761` | Unknown frame/group | Unverified |
| `Frame 1410125759` | Unknown frame/group | Unverified |
| `Frame 1410125765` | Unknown frame/group | Unverified |
| `Frame 1410125764` | Unknown frame/group | Unverified |
| `Frame 1410125758` | Unknown frame/group | Unverified |
| `Frame 1410125766` | Unknown frame/group | Unverified |
| `Frame 17` | Unknown frame/group | Unverified |
| `Home Indicator` | Likely bottom system indicator shown in reference | Name and screenshot agree; node relationship unverified |
| `Container` | Likely a generic content/panel container | Unverified; generic name |
| `iconsax-eye-slash` | Likely the slashed-eye password-field icon | Name agrees with screenshot and `eyeoff.svg`; exact layer-to-file mapping unverified |

Visual grouping to preserve for later node mapping: root/screen; background image region;
white form panel; title and account prompt; email label/field/envelope; password
label/field/eye icon; forgot-password text; primary Login CTA; divider; Google and Apple
provider buttons/logos; home indicator. The supplied frame IDs cannot currently be assigned
to these groups reliably.

## Screenshot-derived geometry estimates

All coordinates below are approximate visual readings in the 402 × 874 reference raster,
origin at its top-left. They are not Figma measurements.

| Element | Approximate position / size |
|---|---|
| White panel | Starts around y=42; fills to bottom; upper corner radius appears about 28–32 px |
| Title | Centered, around y=74–105 |
| Account prompt | Centered, around y=111–132 |
| Email label | Right aligned, around y=182 |
| Email field | x≈16, y≈208, w≈370, h≈48 |
| Password label | Right aligned, around y=272 |
| Password field | x≈16, y≈295, w≈370, h≈49 |
| Forgot-password text | Right aligned, around y=356 |
| Primary button | x≈16, y≈392, w≈370, h≈56 |
| Divider caption | Centered around y=469 |
| Social buttons | Around y=499–547; two near-equal widths with a small center gap |
| Bottom home indicator | Around y=861; system UI depiction in the reference |

The screenshot shows vertically stacked content in a fixed-height raster. The supplied
annotations include `FIXED` and `SCROLLS`, but they are not associated with named layers in
the notes. It is unknown which element is fixed, which region scrolls, whether the entire
panel or only form content scrolls, and how safe areas or smaller screens are handled.

## Typography, colors, and component appearance

- The title and account prompt use the user-confirmed shared Title and Subtitle styles above.
  Screenshot-visible typography of all other elements remains only qualitative: compact
  right-aligned field labels, muted hints, compact forgot-password text, white-on-black CTA,
  muted divider caption, and dark provider labels. Their exact role-specific sizes, weights,
  line heights, letter spacing, colors, and text-box bounds remain unknown; IBM Plex Sans
  Arabic family is confirmed for all text.
- Main surface appears white; primary CTA appears black with white label and a soft shadow;
  input and social button surfaces appear white with thin light-gray outlines; field and
  provider icons are gray/brand-colored/black as appropriate. Exact color values, opacity,
  border widths, radii, shadows, and effects are not verified.
- No validation/error/loading state is visible in this reference.

## Assets and count visible

Four icon instances are visible in the static screenshot: envelope, slashed eye, Google G,
and Apple mark. The open-eye `eye.svg` is an available alternate-state asset but is not
visible in this screenshot. Local SVG contents match these general visible identities:

- `assets/icons/email.svg`: gray outlined envelope, 20 × 20 SVG viewport.
- `assets/icons/eyeoff.svg`: gray outlined eye with slash, 20 × 20 viewport.
- `assets/icons/eye.svg`: gray outlined open eye, 20 × 20 viewport.
- `assets/icons/googel.svg`: multicolor Google “G”, 17 × 17 viewport.
- `assets/icons/appel.svg`: black Apple silhouette, 14 × 17 viewport.

The last two filenames are retained exactly as found; no renaming is requested. Visible marks
resemble these SVGs, but no Figma layer-to-asset links were available. See
[ASSET-INVENTORY.md](ASSET-INVENTORY.md) for file-level verification.

## Interactions: visible vs inferred

- **Visible requirement:** this is the destination of the Get Started CTA.
- **Possible password toggle (inference only):** a slashed-eye icon is shown and a matching
  open-eye SVG exists. The pair suggests a hidden/visible password state, but the static
  screenshot does not prove tap behavior or state transition.
- **Possible links/actions (inference only):** account-creation prompt, forgot-password
  text, Login button, and Google/Apple buttons look actionable. Their destinations and
  behavior are not established. Do not infer authentication or provider business logic.
- No focus, keyboard, validation, loading, error, disabled, or success states are shown.

## Remaining manual Figma checks

Confirm the root frame dimensions and properties; actual parent-child hierarchy and node-ID
mapping; which nodes are `FIXED` versus `SCROLLS`; original image layer and crop; exact
spacing/constraints/safe-area behavior; role and typography for the unassigned Login text
elements; input/button dimensions, borders, radii and effects; icon component mappings and
states; supported interaction states; and behavior/destinations of the apparent links and
social buttons. Shared Title/Subtitle styles and the IBM Plex Sans Arabic family are user-
confirmed, not screenshot estimates.
