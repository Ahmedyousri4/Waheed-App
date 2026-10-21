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
