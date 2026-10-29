# Figma Selection Master Index — Account and Legal Screens

## Source and status

- Source: [Figma selection root 472:6759](https://www.figma.com/design/OwhGcfZwmermbcH2L8rfUD/Waheed-Hassan--Copy-?node-id=472-6759&t=FV85ULAHyUJcsq0M-4)
- Root name: `الشروط والاحكام ,سياسة الخصوصية` (Arabic punctuation/casing preserved as returned)
- Root type/bounds: section, 3609 × 1273, canvas origin (-14210, 3539).
- Direct screen-like frames discovered: **8**.
- Extraction: 0 fully detailed; 8 partial; 0 not inspected. All eight received design-context output; not all layer properties were retained in a way sufficient for exact per-layer audit.
- Figma screenshots returned: 3 (delete confirmation `1068:2733`, identity confirmation `1070:3983`, guest account `498:3926`); not visually reviewed or saved locally. Five screenshot requests were blocked by the Starter-plan tool call limit.
- Exports verified: 0. Figma asset references were temporary; export follow-up was blocked by quota.
- Prototype transitions verified: 0. Navigation is unknown, not inferred from canvas placement.
- No Flutter implementation or application configuration was changed.

## Screen inventory and canvas order

Canvas order is the direct-child sequence returned by metadata, with each child’s reported coordinates retained. It does not establish journey order.

| Canvas sequence | Screen | Figma node | Parent | Canvas x,y | Size | Specification | Status |
|---:|---|---|---|---:|---:|---|---|
| 1 | الحساب - مستخدم | `1068:2903` | `472:6759` | 1410,100 | 402×1106 | [01](SELECTION-SCREEN-01-ACCOUNT-SIGNED-IN.md) | Partial |
| 2 | تأكيد الحذف | `1068:2733` | `472:6759` | 2275,100 | 402×874 | [02](SELECTION-SCREEN-02-DELETE-CONFIRMATION.md) | Partial |
| 3 | تأكيد الهوية | `1070:3983` | `472:6759` | 2717,100 | 402×874 | [03](SELECTION-SCREEN-03-IDENTITY-CONFIRMATION.md) | Partial |
| 4 | تم الحذف | `1070:4185` | `472:6759` | 3159,100 | 402×874 | [04](SELECTION-SCREEN-04-DELETE-SUCCESS.md) | Partial |
| 5 | الحساب - زائر | `498:3926` | `472:6759` | 968,100 | 402×884 | [05](SELECTION-SCREEN-05-GUEST-ACCOUNT.md) | Partial |
| 6 | الشروط والاحكام | `472:6621` | `472:6759` | 100,100 | 402×884 | [06](SELECTION-SCREEN-06-TERMS.md) | Partial |
| 7 | سياسة الخصوصية | `472:6644` | `472:6759` | 534,100 | 402×884 | [07](SELECTION-SCREEN-07-PRIVACY.md) | Partial |
| 8 | تحذير | `1068:3293` | `472:6759` | 1848,100 | 402×450 | [08](SELECTION-SCREEN-08-DELETE-WARNING.md) | Partial |

## Selection-wide observations (verified from returned Figma context)

- All named screens use a 402 px frame width. Heights range 450–1106 px. Exact frame names, IDs, coordinates, and dimensions are listed above.
- Screens 01–04 and 08 show account settings/delete-related structure. The signed-in account metadata includes profile name/avatar, profile edit, language, favorites, orders, help, terms, privacy, delete account, logout, header, status bar, bottom navigation, and home indicator.
- Guest account `498:3926` includes header/status/system bar/bottom navigation, welcome copy, sign-in/create-account CTA, language/help/terms/privacy settings.
- Terms and privacy frames each show a header, cart placeholder/action instance, title, back-arrow instance, system bar, and a 64×64 vector at (169,181). Body/legal text is not exposed in the returned hierarchy.
- Delete warning `1068:3293` is a 402×450 bottom-sheet-like frame with drag handle, warning icon, title/body copy, confirmation checkbox, and two action rows/buttons. Exact button actions remain unknown.
- Design context reports `#1B1B1B`, `#FFFFFF`, `#EEEEEE`, IBM Plex Sans Arabic styles (20/16/14 px with weights 700/500/400, line-height 100%, tracking 0), and background blur radius 48 for some overlays. These are context-level styles, not a complete screen-by-screen token binding.
- Local `AppImage` supports SVG assets by filename in `assets/icons/`, raster filenames in `assets/images/`, JSON in `assets/lotties/`, and HTTP network URLs. Figma’s SVG/vector exports are not verified local matches.

## Related specifications

- [Screen flow](SCREEN-FLOW.md) — verified versus unknown transitions.
- [Design tokens](DESIGN-TOKENS.md) — selection addendum and existing project tokens kept distinct.
- [Asset inventory](ASSET-INVENTORY.md) — export blockers and local candidates.
- [Component inventory](COMPONENT-INVENTORY.md) — repeated Figma patterns and project mapping.
- [Implementation brief](IMPLEMENTATION-READY-BRIEF.md) — readiness and next implementation prerequisites.
- [Coverage report](EXTRACTION-COVERAGE-REPORT.md) — exact scope and blockers.

## Unresolved blockers

1. Figma Starter plan call limit prevented complete screenshot review, targeted metadata follow-up, style/variable enumeration, prototype inspection, and asset export. See coverage report.
2. No verified prototype connections; routes, triggers, back behavior, and modal state transitions remain unknown.
3. Exact typography, fill/stroke/effect bindings, Auto Layout/constraints, scroll/fixed behavior, and per-layer asset exports require renewed Figma access.
4. Legal body content is not exposed in the returned frame hierarchy; do not invent terms or privacy text.
5. Existing local icon candidates are not mapped to these exact Figma nodes. Verify before reuse.
6. IBM Plex Sans Arabic is reported by Figma but is not registered in this app; the established local fallback policy is Cairo, but any selection-wide font decision remains implementation-context only.


## Durable archive

The resumable archive lives in `extraction-archive/`: [session log](extraction-archive/EXTRACTION-SESSION-LOG.md), [category state](extraction-archive/EXTRACTION-STATE.json), [screen registry](extraction-archive/SCREEN-REGISTRY.json), [asset registry](extraction-archive/ASSET-REGISTRY.json), and per-node records in `extraction-archive/NODE-EXTRACTION-RECORDS/`. Raw MCP response files were unavailable and were not fabricated.
