# Screen 01 — Get Started (البدء الآن)

## Sources and confidence

- **Manually supplied Figma notes:** node `549:8382`, frame `Frame 1410125756`, dimensions
  `402 × 874`, corner radius `44`, opacity `100%`, fill `#FFFFFF`, Clip content enabled.
  These values were manually read by the user and not re-read through Figma MCP.
- **Local visual reference:** [`assets/images/getstarted.png`](../../../assets/images/getstarted.png),
  confirmed PNG, `402 × 874` px. Visual inspection shows a complete screen render, not a
  background-only photo. It is evidence for its own displayed composition, not established
  as the current Figma frame export.
- **Separate photo:** [`assets/images/background.jpg`](../../../assets/images/background.jpg),
  confirmed JPEG, `900 × 1350` px. It shows the same suited man and setting without the
  screenshot's darkening, UI, or crop. Its relation to the Figma image layer is plausible
  but unverified; the two files are not duplicates.

## Frame and layout

### Exact values from manual notes

| Property | Value | Source |
|---|---:|---|
| Frame name | `Frame 1410125756` | Manual Figma notes |
| Width × height | `402 × 874` | Manual Figma notes |
| Corner radius | `44` (units as supplied) | Manual Figma notes |
| Opacity | `100%` | Manual Figma notes |
| Fill | `#FFFFFF` | Manual Figma notes |
| Clip content | Enabled | Manual Figma notes |

### Screenshot observations and estimates

The local 402 × 874 reference render has a full-bleed portrait across approximately the top
three quarters, darkened behind white text. A white bottom panel with rounded upper corners
occupies roughly the bottom quarter. It contains a centered heading, centered two-line
description, then a near-full-width black rounded CTA. A black horizontal system
home-indicator mark is visible at the bottom. These relative positions are visual estimates
from the PNG, not exact Figma measurements or confirmed layout constraints.

The portrait is vertically cropped to fit the screen width; the lower portion is obscured by
the white panel. `background.jpg` is portrait 2:3, while the screen is about 0.46 aspect
ratio. Exact image fit, focal point, overlay opacity, panel height/radius, safe-area
treatment, scrolling, and responsive rules are unknown.

## Content and typography

The following values are **user-approved specifications** and take precedence over visual
estimates from the local screenshot. Font family for all Screen 01 text is **IBM Plex Sans
Arabic**.

| Role | Exact text | Family | Weight | Size | Line height | Letter spacing | Alignment | Color |
|---|---|---|---:|---:|---:|---:|---|---|
| Title | `إطلالة تليق بك` | IBM Plex Sans Arabic | 600 (SemiBold) | 24 px | 100% | 0 | Center | `#000000` |
| Subtitle | `تسوّق أو استأجر بدلتك المفضلة بخطوات بسيطة وتجربة فاخرة.` | IBM Plex Sans Arabic | 400 (Regular) | 14 px | 22.75 px | 0 | Center | `#000000` |
| Description | `مجموعة حصرية من البدلات والإكسسوارات الفاخرة...` | IBM Plex Sans Arabic | 400 (Regular) | 14 px | 100% | 0 | Right | `#939393` |
| CTA label | `البدء الآن` | IBM Plex Sans Arabic | Not supplied | Not supplied | Not supplied | Not supplied | Centered in screenshot (estimate) | White in screenshot (estimate) |

Preserve all three text strings exactly, including the subtitle's tashkeel and the
description's literal three-dot ellipsis. Do not complete the description. The description
is present in the user-approved specification; it is not legible as a separate text layer
in the local reference render, so its displayed placement/order remains to be checked.

### Screenshot comparison

The local screenshot shows title `إطلالة تليق بك` and copy rendered as `تسوق أو استأجر
بدلتك المفضلة بخطوات بسيطة وتجربة فاخرة.` It visually corresponds to the approved title and
subtitle, though the screenshot transcription lacks the supplied shadda in `تسوّق`. The
screenshot does not expose the separate gray right-aligned Description string above. Treat
the approved text and typography table as confirmed; keep layout/placement of the separate
Description unresolved.

The app currently registers Inter and Cairo in `pubspec.yaml`, not IBM Plex Sans Arabic.
That is an implementation prerequisite to handle in a future, separately authorized code
task; this documentation task does not change fonts, assets, or pubspec.

## Styling and interactions

- Screenshot-observed: darkened photo area; white lower panel; black CTA with a soft visible
  shadow; white CTA label; rounded device-frame silhouette and black bottom gesture mark.
- These are screenshot observations. Overlay alpha, shadow parameters, exact colors outside
  the supplied frame fill, button size/radius, and panel radius are unverified.
- Required transition from the task: pressing `البدء الآن` opens Screen 02 (Login). This is a
  requirement, not a transition observed in the static reference. No other behavior is
  documented.

## Asset mapping and unresolved items

`getstarted.png` is a full-screen screenshot/reference image containing composed UI; do not
use it as the production background photo. `background.jpg` is a separate photo candidate
and visually matches the portrait subject/scene, but its exact Figma node/layer mapping is
unknown. The manually supplied path `assets/images/GetStarted.jpg` does not exist; do not
rename it or assume it equals either existing file.

Still requiring Figma confirmation: exact image layer source and fit; text element positions
and boxes, especially placement/order of the separate Description; margins, panel/button
dimensions and radii; overlay/effect values; CTA typography beyond its family; safe area,
scroll/overflow, responsive constraints; and additional assets or interactive states.
Screenshot-derived geometry and styling remain estimates; the typography values in the
approved table are not estimates.
