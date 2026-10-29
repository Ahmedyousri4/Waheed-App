# Component Inventory — Selection 472:6759

## Evidence and scope

Based on metadata and design-context responses for root `472:6759` and its eight direct frames. Component source definitions and variant property inventories were not retrieved before the Figma Starter-plan limit. Treat names below as observed instances/patterns, not a complete component-library audit.

| Pattern | Figma evidence | Reuse observation | Flutter mapping |
|---|---|---|---|
| Header: cart slot, centered title, back arrow | repeated in all top-level screens; e.g. `472:6622`–`6626`, `498:3927`–`3931` | Shared header pattern; cart slot appears opacity 0 in returned context for legal page | Inspect existing app bar/back-button/cart widgets; do not create Core component until consumers/API verified |
| System status bar and home indicator | repeated children, e.g. `472:6627` and `498:4005`, home-indicator pill | System chrome repeated; not necessarily app-owned | Preserve platform/system behavior where appropriate; exact safe-area behavior unknown |
| Bottom navigation | account frames; instance `nav bar`, e.g. `1068:3017` | Shared component instance; source/variants unavailable | Inspect existing navigation widget and selected state API |
| Account settings row | profile edit, language, favorites, orders, help, legal links, delete/logout | Repeated 36 px icon slots, 48 px rows; groups and separators visible | Feature-local reusable row may be appropriate; map to existing widgets after inspection |
| Confirmation sheet | `1068:2824`, `1068:3293` | 402 px wide; 450 px and 450 px top-level sheet/frame variants/states; warning/checkbox/actions | Inspect modal/bottom-sheet conventions; no route/action should be invented |
| Confirmation success state | `1070:4396` nested in identity confirmation context | centered illustration, success text, CTA instance `Component 8` | Feature-local state/sheet if confirmed by flow |
| Repeated icons | arrow-left, cart, heart, box, profile, language, help/headphone, trash, logout, warning/check | Mix of instances, vectors, and frames; asset export mapping incomplete | Use verified local asset only after exact match; `AppImage` supports SVG/raster/JSON within documented path rules |

## Project conventions to preserve

- Existing Core component: [`AppImage`](../../../lib/core/widgets/app_image.dart) accepts `image`, optional width/height/color/fit. SVG filename resolves under `assets/icons/`; raster under `assets/images/`; `.json` under `assets/lotties/`; HTTP goes through `Image.network`. It does not expose arbitrary SVG path, crop-position, or asset bundle parameters.
- Core must not import feature modules. Keep selection-specific patterns feature-local unless actual cross-feature use justifies Core reuse under `.agents/skills/ai-core-integration/SKILL.md`.
- Follow existing imperative Navigator conventions and strict 300-line source-file limit. Do not introduce routing/state packages or architecture redesign.

## Unknowns

Component source IDs/variant values, interactive states, exact reuse with existing app Core, and legal-page content remain unverified. See [coverage](EXTRACTION-COVERAGE-REPORT.md).
