# Figma Design Tokens — Get Started and Login

## Evidence status

Figma MCP was not called. User-supplied manual notes for Screen 01 node `549:8382` report
frame fill `#FFFFFF`, opacity `100%`, corner radius `44`, frame size `402 × 874`, and Clip
content enabled. These are exact reported Figma values, not independently re-verified. The
shared typography below is also user-confirmed and now applies to both screens. No other
Screen 02 visual tokens were supplied.

Local reference images provide visual evidence of white panels, black buttons, gray borders
and hints, and a dark photo overlay on Get Started. These are **screenshot observations**;
no numeric colors, overlay alpha, border width, or effect values were extracted from pixels
and none should be treated as a Figma token. The `getstarted.png` image itself shows text
that differs from the manually supplied Screen 01 copy; see the screen specification.

No Figma variable/style names, component references, or token collections are available.
Existing project tokens below are from Flutter source and are not automatically equivalent
to the designs.

## User-confirmed shared typography

These styles were approved for Screen 01 and then explicitly applied to matching text roles
on Screen 02. They are user-confirmed specification values, not screenshot estimates.

| Shared role/style | Family | Weight | Size | Line height | Letter spacing | Alignment | Color |
|---|---|---:|---:|---:|---:|---|---|
| Title | IBM Plex Sans Arabic | 600 (SemiBold) | 24 px | 100% | 0 | Center | `#000000` |
| Subtitle | IBM Plex Sans Arabic | 400 (Regular) | 14 px | 22.75 px | 0 | Center | `#000000` |
| Description | IBM Plex Sans Arabic | 400 (Regular) | 14 px | 100% | 0 | Right | `#939393` |
| Other text, including CTA labels | IBM Plex Sans Arabic | Role-specific values not supplied | — | — | — | — | — |

Screen 01's copy is recorded in `SCREEN-01-GET-STARTED.md`; Login retains its own copy and
its role-to-style assignments are recorded in `SCREEN-02-LOGIN.md`. The shared style table
does not transfer text content between screens. The Screen 01 subtitle tashkeel and
description's literal `...` must be preserved. The separate Screen 01 Description's
placement remains unverified against Figma.

## Existing project color tokens

Source: `lib/app/theme/app_colors.dart`.

| Project token | Value |
|---|---|
| `gold` | `#C9A961` |
| `goldDark` | `#473100` |
| `navy` | `#314158` |
| `black`, `textPrimary` | `#111111` |
| `background` | `#FAFAFA` |
| `surface`, `white` | `#FFFFFF` |
| `border` | `#ECECEC` |
| `borderLight` | `#F0F0F0` |
| `divider` | `#E2E8F0` |
| `textSecondary` | `#8F8F8F` |
| `textMuted` | `#A0A0A0` |
| `textSlate` | `#94A3B8` |
| `textSlateSecondary` | `#64748B` |
| `textHint` | `#BFC6D0` |
| `surfaceLight` | `#F1F5F9` |
| `surfaceSubtle` | `#F8FAFC` |
| `surfaceMeasurements` | `#F7F8FA` |
| `warning` | `#FFFBEB` |
| `warningText` | `#7B3306` |
| `star` | `#FFC107` |
| `inactive`, `pageIndicator` | `#E2E8F0`, `#D9D9D9` respectively |
| `error` | Flutter `Colors.red`; no explicit hex in this source |

## Existing project typography

Source: `lib/app/theme/app_text_styles.dart` and `pubspec.yaml`.

| Project style | Family | Size | Weight | Color |
|---|---|---:|---:|---|
| `heading` | Inter | 22 | bold | `textPrimary` |
| `titleLarge` | Inter | 17 | bold | `textPrimary` |
| `titleMedium` | Inter | 16 | bold | `textPrimary` |
| `titleSmall` | Inter | 14 | bold | `textPrimary` |
| `bodyLarge` | Inter | 15 | 600 | `textPrimary` |
| `body` | Inter | 13 | normal | `textSecondary` |
| `bodySmall` | Inter | 12 | normal | `textSlate` |
| `label` | Inter | 14 | 700 | `textPrimary` |
| `labelSmall` | Inter | 11 | normal | `textSlate` |
| `stepLabel` | Inter | 12 | 500 | `gold` |
| `brand` | Inter | 13 | 900 | black |
| `navLabel` | Inter | 11 | 600 | `textMuted` |
| `navLabelActive` | Inter | 11 | bold | black |

`pubspec.yaml` registers Inter with weights 400–900 and Cairo with regular, 500, 600, and
700 weights. Cairo font files are present. IBM Plex Sans Arabic is **not currently
registered** in the inspected `pubspec.yaml`. It is the user-confirmed family for all text on
both screens; a future implementation task will need to address font
availability/registration. Do not substitute project defaults for this confirmed family.

## Screenshot-visible typography and styling (qualitative only)

- Screen 01 screenshot: title and subtitle correspond to the approved copy; use the shared
  styles above. A separate description role is specified, but its screenshot placement is
  unresolved.
- Screen 02 screenshot: centered bold-looking Arabic title, smaller account prompt, compact
  right-aligned labels, white rounded inputs with thin light-gray outlines, muted hints,
  black CTA with white label, thin divider, outlined social buttons.
- SVG source colors: envelope and eye icons use `#939393` in their paths; Google mark uses
  `#4285F4`, `#34A853`, `#FBBC05`, and `#EA4335`; Apple silhouette uses `black`. These are
  verified asset path values, not proof that Figma binds those exact files to the screen.

For Screen 01, title, subtitle, and Description use the confirmed shared styles; other text
uses the confirmed IBM Plex Sans Arabic family but role-specific metrics are unknown. For
Screen 02, the title maps to Title and the account prompt maps to Subtitle; all other text
uses IBM Plex Sans Arabic but its role-specific metrics remain unresolved. Text box
dimensions and placement remain unknown. Across the screens, layout spacing, exact Screen 02
radii, stroke widths, gradients, shadows, overlay opacity, and responsive breakpoints remain
unknown. Preserve the project token table below as implementation context only; do not fill
unknown design values from project defaults.

## Remaining Figma values to confirm

For both screens: actual text styles and variables, spacing scale, sizing constraints,
borders, radii, opacity, gradients, shadows/blur, and reusable component definitions. For
Screen 01 specifically, confirm whether radius `44` applies to the outer frame or another
selection, and confirm image crop/overlay and the authoritative copy. For Screen 02, obtain
exact frame geometry, input/button dimensions, radii, colors, and `FIXED`/`SCROLLS` node
assignments.
## Figma selection 472:6759 - token addendum

Returned design-context output names IBM Plex Sans Arabic and includes styles described as Title2 Bold 20 px/700, Body1 Medium 16 px/500, Body1 Regular 16 px/400, and Body2 Regular 14 px/400; line height 100% and letter spacing 0. Context also lists #1B1B1B, #FFFFFF, #EEEEEE, and background-blur radius 48. These are context-level values, not complete per-layer bindings or Figma variable IDs. See SELECTION-MASTER-INDEX.md for scope. IBM Plex Sans Arabic is not registered in pubspec.yaml; existing project documentation identifies Cairo as fallback. Do not treat current Flutter theme values as matching Figma tokens without evidence.