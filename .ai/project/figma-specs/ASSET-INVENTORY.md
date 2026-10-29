# Figma Screen Asset Inventory

## Verification method and limits

The eight listed local files were checked by exact path. Raster file types, pixel
dimensions, and byte lengths were read from the files. SVG opening tags, dimensions/viewBox,
and visible path content were inspected; SVGs were not renamed or modified. Both PNG
references and `background.jpg` were visually opened. The Figma MCP was not called, so file
existence/content is verified locally but no Figma layer-to-export mapping is confirmed.

`pubspec.yaml` already declares the asset directories `assets/images/` and `assets/icons/`.
No asset path or pubspec entry was changed.

## Confirmed files

| Exact path | Type / size | Verified visible content | Screen/source association | Status |
|---|---|---|---|---|
| `assets/images/getstarted.png` | PNG, 402 × 874 px, 209,670 bytes | Complete Get Started screen render: suited man/photo darkened above a white rounded lower panel; Arabic heading/description; black CTA; bottom home indicator | Screen 01 local reference candidate; not a production background asset or confirmed Figma export | Exists; visually inspected |
| `assets/images/background.jpg` | JPEG, 900 × 1350 px, 140,225 bytes | Portrait photograph of a man in a navy suit in a glass-fronted setting; no UI overlay | Separate original-photo candidate for Screen 01; exact Figma layer relation unconfirmed | Exists; visually inspected |
| `assets/images/login (2).png` | PNG, 402 × 874 px, 114,547 bytes | Complete Login screen render with top photo strip, white form panel, email/password fields, CTA, social buttons and home indicator | Screen 02 local reference candidate; raster size is not independently verified Figma frame size | Exists; visually inspected |
| `assets/icons/email.svg` | SVG, 20 × 20 viewBox, 1,233 bytes | Gray outlined envelope | Visually consistent with email-field icon in Screen 02; node mapping unconfirmed | Exists; inspected |
| `assets/icons/eyeoff.svg` | SVG, 20 × 20 viewBox, 1,717 bytes | Gray outlined eye crossed by diagonal slash | Visually consistent with password-hidden icon in Screen 02; node mapping unconfirmed | Exists; inspected |
| `assets/icons/eye.svg` | SVG, 20 × 20 viewBox, 996 bytes | Gray outlined open eye | Candidate alternate visible-password state; not shown in static Login reference | Exists; inspected |
| `assets/icons/appel.svg` | SVG, 14 × 17 viewBox, 1,160 bytes | Black Apple silhouette | Visually consistent with Apple mark in Screen 02 provider button; node mapping unconfirmed | Exists; inspected |
| `assets/icons/googel.svg` | SVG, 17 × 17 viewBox, 1,108 bytes | Four-color Google “G” | Visually consistent with Google mark in Screen 02 provider button; node mapping unconfirmed | Exists; inspected |

## Relationship between the two Screen 01 image files

`getstarted.png` is a composed screenshot because it visibly contains screen text, panel,
button, photo treatment, and device indicator. `background.jpg` is a separate, larger,
uncomposited photo showing the same model and setting. Their formats, dimensions, and
content differ. The local reference suggests that the JPEG could supply the portrait
region, but does not establish its exact source-node mapping, crop, or whether it is the
precise image in Figma. Do not use the screenshot PNG as the screen's image layer.

## Manually named but absent path

The prior manual note named `assets/images/GetStarted.jpg`; that exact path does not exist.
The existing `assets/images/getstarted.png` is a screenshot render, not a file proven to be
the named source asset. Preserve both exact facts; do not rename or treat one as the other.

## Export/call-site status

No files were downloaded, copied, renamed, or altered. No Flutter call sites have been
implemented or verified. The SVG logos/icons match the reference visually by their paths
and appearance, but exact Figma component/node IDs, export scale, and production usage remain
unknown.

## Screen 03 — Sign Up (Figma node `549:8455`)

The local mappings below were checked against the actual files. The supplied Flutter export
uses empty `Stack()` placeholders for visual assets; therefore local type/content/existence
is verified, while exact Figma-node byte matching is not claimed. No assets were downloaded,
copied, or modified. The background path is required by the task and is already used by the
Get Started and Login auth screens.

| UI location / local evidence | Exact local path | Status and notes |
|---|---|---|---|
| Full-frame background | `assets/images/background.jpg` | Exists; JPEG, 900 × 1350 px, 140,225 bytes. Use behind 70% black overlay. Same image is already used by Get Started/Login. |
| Full-name profile icon | `assets/icons/profilee.svg` | Exists; SVG, 20 × 20 viewBox, 712 bytes, `#939393` profile outline. Requested Sign Up icon. Distinct from preserved `assets/icons/profile.svg` (24 × 24, `#919191`). |
| Phone handset | `assets/icons/call.svg` | Exists; SVG, 20 × 20 viewBox, 1,908 bytes, `#939393` handset outline. Suitable color/style for the Sign Up phone field. |
| Alternate phone icon | `assets/icons/phone.svg` | Exists; SVG, 20 × 20 viewBox, 1,890 bytes, handset outline with `#858585` stroke. Exists but not selected; use `call.svg` to match the auth gray. |
| Phone separator | Flutter-drawn 26 × 1 px line | No image asset required. Use `#EAEAEA` and rotate 1.57 rad as in export. |
| Email field | `assets/icons/email.svg` | Exists; SVG, 20 × 20 viewBox, 1,233 bytes, envelope paths `#939393`. |
| Hidden/visible password controls | `assets/icons/eyeoff.svg`, `assets/icons/eye.svg` | Both exist; SVG, 20 × 20 viewBox; eye/eye-slash strokes `#939393`. |
| Google provider button | `assets/icons/googel.svg` | Exists; SVG, 17 × 17 viewBox, 1,108 bytes, Google brand colors. Preserve filename spelling. |
| Apple provider button | `assets/icons/appel.svg` | Exists; SVG, 14 × 17 viewBox, 1,160 bytes, black Apple mark. Preserve filename spelling; place within 20 × 20 slot without changing intrinsic size. |

The local SVG contents and intended visual roles are verified. Since the supplied Figma-to-Code export emits empty SVG `Stack()` placeholders and no fresh Figma asset export was possible, exact Figma-node export identity remains unverified. The earlier MCP Starter-plan limit remains a limitation on renewed Figma inspection; it does not prevent implementation using these requested, existing local files. No Screen 03 assets were exported or changed.
## Figma selection 472:6759 - asset audit addendum

No asset file was downloaded or exported for this selection. Design-context output included temporary Figma asset references for SVG/vector content; the Starter-plan call limit blocked export follow-up. Do not use temporary URLs as application references. Existing local icon files are candidates only; no exact match from these nodes is verified. Identified visual roles include avatar, cart, back arrow, account-menu symbols, warning/delete artwork, and legal-page vector artwork. The number of distinct exportable source assets is not recoverable from the saved project records. Exact local paths, Figma layer mapping, image dimensions, export format, and destination remain pending.