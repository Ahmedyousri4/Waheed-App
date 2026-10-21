# Figma Screen Specification — Booking Confirmation (تم التأكيد)

## Handoff status

Metadata and design context inspection has been augmented with direct visual evidence from two high-resolution rendered screenshots of Figma node `3526:6123` (capturing both the upper and lower halves of the screen). These screenshots visually confirm full screen composition, footer button styling, exact visible address text (correcting an earlier metadata truncation discrepancy), tailoring status subline coloring, emblem checkmark icon, and icon placements. Implementation has not started. No application code, routing, or assets were changed.

## 1. Source and inspection method

- **Figma file key:** `OwhGcfZwmermbcH2L8rfUD`
- **Node:** `3526:6123`, named `تم التأكيد` (Booking Confirmation)
- **Type and dimensions:** frame, 402 × 1195 Figma units.
- **Source:** [Booking Confirmation — Figma](https://www.figma.com/design/OwhGcfZwmermbcH2L8rfUD/Waheed-Hassan%E2%80%93Copy-?node-id=3526-6123&t=JSg8Kr6CuulAlGaF-4)
- **Methods used:** Figma MCP `get_design_context` for node `3526:6123` and `get_metadata` for the full hierarchy, supplemented by visual inspection of two high-fidelity rendered screenshots covering the upper and lower screen regions.
- **Evidence limits:** Geometry, layer hierarchy, and baseline colors originate from the JSX-style design context and metadata. Visual styling, button treatments, address text correction, and icon shapes are verified directly from the screenshots. Remaining unverified properties (e.g. exact stroke token on the secondary button, font weight numbers) are explicitly noted.
- **Coordinates:** Figma units. Metadata positions are relative to each parent unless explicitly identified as root coordinates.

## 2. Screen overview and verified hierarchy

An Arabic appointment pickup confirmation showing a booking success header, an order number with a copy control, a large QR code and instruction, then branch, pickup appointment, and tailoring-status details. Two footer actions and an iOS-style home-indicator area are positioned near the bottom of the 1195-unit frame.

```text
تم التأكيد — 3526:6123 (402 × 1195; #FAFAFA; clipped; 44 radius)
├─ Header/gradient — 3526:6124 (x 0, y 53, 402 × 225)
│  ├─ Gold decoration — 3526:6125 (x 264.8, y -40, 176 × 176; 15% opacity)
│  ├─ Gold decoration — 3526:6126 (x -40, y 97, 176 × 176; 10% opacity)
│  └─ Centered header content — 3526:6127 (x 0, y 24, 400.8 × 153; horizontal padding 24)
│     └─ Content group — 3526:6128 (226 × 153)
│        ├─ Gold circular emblem — 3526:6129 (80 × 80; shadow)
│        │  └─ Icon artwork — 3526:6130 (40 × 40; solid white checkmark ✓)
│        └─ Title/copy — 3526:6132 (y 96; gap 4)
│           ├─ “تم تأكيد الحجز” — 3526:6133
│           └─ “استلم بدلتك من الفرع في الموعد المحدد” — 3526:6134
├─ Booking/QR card — 3526:6135 (x 16, y 302, 370 × 430.6; padding 20)
│  ├─ Booking number row — 3526:6136 (330 × 41; justify-between)
│  │  ├─ Copy control — 3526:6137 (42 × 16; leading/left-aligned)
│  │  │  ├─ Copy glyph — 3526:6138 (12 × 12; two overlapping rounded squares)
│  │  │  └─ “ نسخ” — 3526:6141 (text includes a leading space)
│  │  └─ Right-aligned order details — 3526:6142 (94.425 × 41; trailing/right-aligned)
│  │     ├─ “رقم الطلب” — 3526:6144
│  │     └─ “EQ-862334” — 3526:6146
│  ├─ QR section — 3526:6147 (x 20, y 61, 330 × 321.6)
│  │  └─ QR surface — 3526:6148 (x 0, y 16, 330 × 305.6; padding 20; pale gray/blue #F8FAFC)
│  │     └─ QR artwork — 3526:6149/6150 (176 × 176; dark navy pattern)
│  └─ Instruction — 3526:6229 (x 20, y 382.6, 320.8 × 28; centered)
│     ├─ Instruction icon — 3526:6230 (14 × 14; miniature gold QR code icon)
│     └─ “اعرض هذا الرمز في الفرع للاستلام” — 3526:6243
├─ Booking details card — 3526:6244 (x 16, y 748, 370 × 255.6; padding 16)
│  ├─ Branch row — 3526:6245 (x 16, y 16, 338 × 58; gap 12)
│  │  ├─ Icon tile — 3526:6246 (40 × 40; radius 14; pale navy fill; left-positioned)
│  │  │  └─ Vuesax shop instance — 3526:6247 (20 × 20; storefront icon)
│  │  └─ Branch text — 3526:6248 (286 × 58; RTL/right-aligned)
│  │     ├─ “فرع الاستلام” — 3526:6250
│  │     ├─ “الفرع الرئيسي – ميت غمر” — 3526:6252
│  │     └─ Address — 3526:6254: “ميت غمر، شارع المعاهده بجوار كلية التربية النوعية”
│  ├─ Dashed divider — 3526:6255/6256 (top padding 12; 338 × 0.8)
│  ├─ Pickup time row — 3526:6257/6258 (top padding 12; row 338 × 58)
│  │  ├─ Icon tile — 3526:6259 (40 × 40; radius 14; pale navy fill; left-positioned)
│  │  │  └─ Iconsax calendar artwork — 3526:6260 (20 × 20)
│  │  └─ “موعد الاستلام” / “الأربعاء، ٢٠ مايو” / “١١:٠٠ ص” — 3526:6277/6279/6281
│  ├─ Dashed divider — 3526:6282/6283 (top padding 12; 338 × 0.8)
│  └─ Tailoring status row — 3526:6284/6285 (top padding 12; row 338 × 58)
│     ├─ Gold icon tile — 3526:6286 (40 × 40; radius 14; pale gold fill; left-positioned)
│     │  └─ Iconsax scissors artwork — 3526:6287 (20 × 20)
│     └─ “حالة التفصيل” / “قيد التحضير” / “جاهز خلال ٣ أيام” (gold) — 3526:6298/6300/6302
├─ System bar — 3526:6303 (x 0, y 0, 402 × 53)
│  ├─ Status indicators — 3526:6304 (x 311, y 21.33, 66.66 × 11.34)
│  └─ Time label — 3526:6318/6319 (“9:41”)
└─ Bottom action/system region — 3526:6320 (x 0, y 1082, 402 × 113)
   ├─ Action bar — 3526:6321 (402 × 80; white surface)
   │  ├─ “تتبع الطلب” (Primary) — 3526:6322/6323 (x 16, y 12, 180 × 56; solid black fill, white text)
   │  └─ “الرئيسية” (Secondary) — 3526:6324/6325 (x 206, y 12, 180 × 56; white fill, border, home icon on right)
   │     └─ home-2 instance — 3526:6326 (24 × 24)
   └─ Home-indicator region — 3526:6327/6328 (y 80, 402 × 33)
      └─ Home indicator — 3526:6329 (139 × 5; centered black pill bar)
```

The frame is 1195 high. The action region starts at y=1082; it is not within a 905-unit crop. The root context says overflow is clipped. A scroll view, sticky behavior, breakpoint, or device-safe-area mapping is not exposed and must not be inferred from these coordinates.

## 3. Text and typography

All shown typography is reported as **IBM Plex Sans Arabic**. The project has Cairo and Inter fonts, but no bundled IBM Plex Sans Arabic font was found. Exact project font substitution needs an implementation decision; do not represent Cairo/Inter as an exact match. Figma direction is `dir="auto"`; Arabic text is right-aligned where stated.

| Node | Exact content from Figma response | Family / style | Size / line height | Tracking / alignment / color |
|---|---|---|---|---|
| 3526:6133 | `تم تأكيد الحجز` | IBM Plex Sans Arabic Bold | 22 / 33 | center; `#FFFFFF` |
| 3526:6134 | `استلم بدلتك من الفرع في الموعد المحدد` | IBM Plex Sans Arabic Regular | 14 / 20 | center; `rgba(255,255,255,0.8)` |
| 3526:6141 | ` نسخ` (leading space is in node content) | IBM Plex Sans Arabic Medium | 12 / 16 | center; `#000000` via black variable |
| 3526:6144 | `رقم الطلب` | IBM Plex Sans Arabic Regular | 11 / 16.5 | right; `#314158` |
| 3526:6146 | `EQ-862334` | IBM Plex Sans Arabic Bold | 16 / 24 | tracking 1 px; right; `#000000` via black variable |
| 3526:6243 | `اعرض هذا الرمز في الفرع للاستلام` | IBM Plex Sans Arabic Regular | 12 / 16 | `#314158`; centered with icon |
| 3526:6250 | `فرع الاستلام` | IBM Plex Sans Arabic Regular | 12 / 16.5 | right; `#62748E` |
| 3526:6252 | `الفرع الرئيسي – ميت غمر` | IBM Plex Sans Arabic SemiBold | 14 / 24 | right; `#0A0A0A` |
| 3526:6254 | `ميت غمر، شارع المعاهده بجوار كلية التربية النوعية` | IBM Plex Sans Arabic Medium | 10 / 16 | right; `#62748E`; visually verified in both screenshots (corrects obsolete metadata text `التجمع الخامس...`). |
| 3526:6277 | `موعد الاستلام` | IBM Plex Sans Arabic Regular | 12 / 16.5 | right; `#62748E` |
| 3526:6279 | `الأربعاء، ٢٠ مايو` | IBM Plex Sans Arabic SemiBold | 14 / 20 | right; `#0A0A0A` |
| 3526:6281 | `١١:٠٠ ص` | IBM Plex Sans Arabic Regular | 11 / 16.5 | right; `#64748B` |
| 3526:6298 | `حالة التفصيل` | IBM Plex Sans Arabic Regular | 12 / 16.5 | right; `#62748E` |
| 3526:6300 | `قيد التحضير` | IBM Plex Sans Arabic SemiBold | 14 / 20 | right; `#0A0A0A` |
| 3526:6302 | `جاهز خلال ٣ أيام` | IBM Plex Sans Arabic Regular | 11 / 16.5 | right; visually rendered in gold accent (`#C9A961` or similar), not slate gray. |
| 3526:6323 | `تتبع الطلب` | IBM Plex Sans Arabic (visually SemiBold/Bold) | 14 / 22 (from text box) | center; white `#FFFFFF` on solid black button |
| 3526:6325 | `الرئيسية` | IBM Plex Sans Arabic (visually SemiBold/Bold) | 14 / 22 (from text box) | black `#000000` text with outline home-2 icon to its right on white bordered button |
| 3526:6319 | System time layer (`9:41`) | SF Pro / system font | 16 px text box | left; visually verified as `9:41` |

Visual evidence confirms the button text colors and layout: `تتبع الطلب` is white text centered on a black solid button, and `الرئيسية` is black text paired with an outline home-2 icon to its right inside a white bordered button. Exact font weights and CSS token values remain to be verified from live Figma node properties.

## 4. Colors and effects

| Element | Exact value exposed by design context | Notes |
|---|---|---|
| Root background | `#FAFAFA` | Root has `overflow-clip` and `rounded-[44px]`. |
| Header gradient start | `#314158` (`rgb(49,65,88)`) | Linear gradient at 150.7641954313°; 0%. |
| Header gradient end | `#0A0A0A` (`rgb(10,10,10)`) | 100%. |
| Header decoration 1 | `#C9A961` at 15% opacity | Node 6125 (soft translucent circle). |
| Header decoration 2 | `#C9A961` at 10% opacity | Node 6126 (soft translucent circle). |
| Header emblem | `#C9A961` | 80 px circle with bold white checkmark (`✓`). |
| Header title | `#FFFFFF` | 22 px bold. |
| Header supporting copy | `rgba(255,255,255,0.8)` | 14 px regular. |
| Main information card | `#FFFFFF` | 24 px radius; shadow `0px 8px 5px rgba(0,0,0,0.1)`. |
| Copy label | `#000000` | Fallback black variable. |
| Order label / general detail labels | `#314158` for order label; `#62748E` for other labels | See typography rows for node mapping. |
| QR backing | `#F8FAFC` | 16 px radius. Border not exposed. |
| Branch/calendar icon tiles | `rgba(30,58,138,0.06)` | 14 px radius. |
| Tailoring icon tile | `rgba(201,169,97,0.13)` | 14 px radius. |
| Branch/date/status values | `#0A0A0A` | Appointment time subline uses `#64748B`. Tailoring status subline `جاهز خلال ٣ أيام` visually uses gold `#C9A961` accent. |
| Detail card | `#FFFFFF` | Radius 16 px; shadow `0px 1px 1.5px rgba(0,0,0,0.1), 0px 1px 1px rgba(0,0,0,0.1)`. |
| Detail separators | `#F1F5F9` | Dashed top border, 0.8 px. |
| Footer surface | `#FFFFFF` | 80 px action bar container above home indicator. |
| Footer primary button (`تتبع الطلب`) | Fill `#000000`, text `#FFFFFF` | Visually verified: solid black fill, 16 px radius, centered white text. |
| Footer secondary button (`الرئيسية`) | Fill `#FFFFFF`, text/icon `#000000`, outline border | Visually verified: white fill, 16 px radius, outline border (exact border stroke token unverified), black text with home icon. |

## 5. Geometry and spacing

| Element | Geometry / spacing / effects |
|---|---|
| Root | 402 × 1195; fill `#FAFAFA`; clipping; 44 px corner radius from context CSS. Whether the radius is device-preview treatment is unresolved. |
| Header | x=0, y=53, 402 × 225; gradient above. Content container x=0, y=24, width 400.8, horizontal padding 24; centered child 226 × 153. |
| Header decorations | Circle 176 × 176 at (264.8,-40) and (-40,97) relative to header. Both clipped by parent bounds. |
| Header content | Emblem 80 × 80; icon 40 × 40; vertical gap 16. Text group begins at y=96, 226 wide, title/body gap 4. |
| Booking card | x=16, y=302, 370 × 430.6; padding 20; radius 24; shadow above. Inner width 330. |
| Booking number row | 330 × 41; copy control at x=0,y=12.5, 42 × 16; details at x=235.575, 94.425 × 41. |
| QR section | section x=20,y=61,330 ×321.6 relative to booking-card content; top padding 16. QR backing is 330 ×305.6, padding 20; QR artwork 176 ×176 centered at x=77,y=64.8 within backing. |
| QR caption | x=20,y=382.6,320.8 ×28 within card content; top inset 12; icon 14 ×14; icon/text gap 6; centered. |
| Detail card | x=16,y=748,370 ×255.6; padding 16; radius 16; white; shadow above. Inner width 338. |
| Detail rows | Row height 58; icon tile 40 ×40; text region 286 ×58; gap 12. First row y=16. Later rows each have a 12 px top inset after 0.8 px dashed separator. Separators are 338 wide. |
| Footer | x=0,y=1082,402 ×113; action bar 402 ×80; buttons x=16 and x=206, each 180 ×56 at y=12 (26 px gap); home-indicator region 402 ×33. |
| Shadows on emblem | `0px 25px 25px rgba(0,0,0,0.25)`. |

No responsive breakpoints, scrolling rule, or behavior below the 1195-unit frame was returned. Do not presume the footer is fixed, or map the system-bar/home-indicator artwork to a real device inset, without a product/platform decision.

## 6. Asset inventory

Figma design-context asset URLs are temporary and must not be pasted into app code. Figma MCP references SVGs for the emblem, copy glyph, QR artwork, QR instruction glyph, Vuesax shop, multiple masked Iconsax assets, and home-2. No Figma assets were downloaded or added. The response does not establish individual third-party licenses for these design-file assets.

| Figma artwork | Existing project asset | Match assessment / format / license | Later implementation path if needed |
|---|---|---|---|
| QR pattern (node 6150, 176 ×176; SVG reference `448c131a-700e-436d-a7df-95c0997d3bf9`) | None found | Missing; visually confirmed as a dark navy QR code on #F8FAFC backing with standard 3 finder corners. License/source terms unverified. | Export from authorized Figma node into `assets/images/booking_confirmation_qr.svg` (or generate via dynamic qr package if live payload required). |
| Gold success emblem icon (node 6130, 40 ×40) | `assets/icons/done.svg` (24 ×24 white tick in circle) | Visually verified: solid gold circular badge with a centered bold white checkmark/tick (`✓`). Local `done.svg` has a circular border rather than a solid checkmark, so an exact checkmark icon is needed. | Export from Figma to `assets/icons/booking_confirmation_success.svg` or render checkmark path inside a decorated gold circle. |
| Copy icon (node 6138, 12 ×12) | None confirmed | Visually verified: two overlapping rounded rectangular sheets (standard copy glyph) to the left of `نسخ`. | Export to `assets/icons/booking_confirmation_copy.svg` if Figma export authorized. |
| QR instruction icon (node 6230, 14 ×14) | None confirmed | Visually verified: miniature gold QR code icon positioned to the right of `اعرض هذا الرمز في الفرع للاستلام`. | Export to `assets/icons/booking_confirmation_instruction.svg`. |
| Shop icon instance (node 6247, 20 ×20; Vuesax `shop`) | `assets/icons/store.svg` | Close candidate, not exact: local Tabler `building-store`, 24 ×24 SVG with black outline; Figma screenshot shows a clean storefront outline inside a pale navy tile. | Reuse only if implementation review accepts the visible difference; otherwise export to `assets/icons/booking_confirmation_shop.svg`. |
| Calendar icon (node 6260, 20 ×20; Iconsax) | `assets/icons/calendar.svg` | Close candidate, not exact: local Tabler outline calendar; screenshot shows calendar outline with tear-off top in pale navy tile. | Reuse only after visual comparison; otherwise export to `assets/icons/booking_confirmation_calendar.svg`. |
| Scissors icon (node 6287, 20 ×20; Iconsax) | None found | Missing exact: visual confirms scissors outline glyph inside a pale gold tile. | `assets/icons/booking_confirmation_scissors.svg` when Figma export is authorized. |
| Home-2 footer icon (node 6326, 24 ×24; instance) | `assets/icons/home.svg` / `homeselected.svg` | Visually verified: linear outline home icon located to the right of `الرئيسية` within the white outlined secondary button. | Compare local `home.svg` with component 6326 before reuse; export if different. |
| System status artwork | None intended | Visually verified: iOS mock chrome showing 9:41, cellular, WiFi, battery. | Handled via Flutter SafeArea / system overlay in production. |

No fonts were downloaded. IBM Plex Sans Arabic is the Figma family; project assets include Cairo and Inter only. No third-party license statement for the Figma-provided assets or IBM Plex font is established by this inspection.

## 7. Existing component and precedent mapping

| Existing item | Match / reason |
|---|---|
| `lib/core/widgets/app_image.dart` (`AppImage`) | Existing shared asset renderer can render supported local SVG/raster assets, if later implementation imports verified assets. |
| `assets/icons/store.svg` | Close-only candidate for the Vuesax shop glyph; outline storefront intent is related, but the actual source/icon set differs. |
| `assets/icons/calendar.svg` | Close-only candidate for the Iconsax calendar; not asserted exact. |
| `assets/icons/done.svg` | Close-only candidate for the success mark; local is a white circled check, whereas Figma uses a bold checkmark on a solid gold circle. |
| `assets/icons/home.svg`, `homeselected.svg` | Possible home glyph candidates only; compare with Figma home-2 instance before reuse. |
| `AppColors` / `AppTextStyles` | `.ai/project/DESIGN-SYSTEM.md` documents white, background `#FAFAFA`, gold `#C9A961`, navy `#314158`, Cairo Arabic, and Inter defaults. Some Figma values match, but multiple values (`#0A0A0A`, `#62748E`, `#64748B`, alpha fills/shadows) do not. Preserve local screen values if approved; do not change global tokens for this inspection. |
| `PickupSchedulingScreen` / `SuccessScreen` specs | Workflow precedents: `.ai/state/figma-choose-appointment-3526-5940-spec.md` and `.ai/state/figma-success-screen-3526-5447-spec.md`. Use for documentation structure and known project conventions, not copied design values. |
| Shared navigation/button components | Visually verified: footer consists of two side-by-side equal-width buttons (180 × 56): a primary solid black button (`تتبع الطلب`) and a secondary white outlined button with home-2 icon (`الرئيسية`). |

## 8. Dynamic content, states, and assumptions

### What the captured design establishes

- The visible sample order reference is `EQ-862334`.
- The sample appointment reads `الأربعاء، ٢٠ مايو` and `١١:٠٠ ص`.
- Sample branch title is `الفرع الرئيسي – ميت غمر`; address is visually confirmed as `ميت غمر، شارع المعاهده بجوار كلية التربية النوعية`.
- Tailoring status content is `قيد التحضير` and `جاهز خلال ٣ أيام` (with the subline rendered in gold font).
- There is a `نسخ` control and two footer buttons: solid black `تتبع الطلب` (left) and white bordered `الرئيسية` with home icon (right).
- These are static text values in the inspected frame. A data contract or proof that they are live/dynamic is absent.

### Not established

- Whether QR content is static or must encode a live booking/order identifier, and what exact value/payload it should contain.
- Whether order ID, branch, address, appointment date/time, and tailoring status are dynamic, and their source/model/API mapping.
- Copy action behavior, confirmation feedback, footer navigation targets, or whether either control has disabled/loading states.
- Exact border color and stroke width on the secondary footer button.
- Exact font weights and CSS token values for footer buttons.
- Accessibility semantics, scroll behavior, viewport resizing, and system safe-area integration.

The sample data must not be presented as a real booking or embedded into production state without product confirmation. This task does not authorize CTA routing or implementation.

## 9. Unresolved questions and inspection limits

1. **Visual review status — RESOLVED**: Two high-resolution screenshots covering the upper and lower halves of node `3526:6123` provided direct visual evidence, confirming overall composition, footer styling, emblem checkmark icon, QR caption icon, and colors.
2. **Branch address text — RESOLVED**: Visually verified as `ميت غمر، شارع المعاهده بجوار كلية التربية النوعية` (overriding the truncated metadata string).
3. **Footer styling — PARTIALLY RESOLVED**: Visually verified as solid black fill with white text for `تتبع الطلب` (left), and white fill with outline border and black text/icon for `الرئيسية` (right). Exact border stroke hex and stroke width require live Figma token confirmation.
4. **Icons visual confirmation — RESOLVED**: Emblem contains a solid white checkmark (`✓`); QR caption has a miniature gold QR code icon; copy control has overlapping rectangles; home button has an outline house icon.
5. Determine the QR payload/data source and whether a static vector export is ever appropriate. The existing Figma QR pattern should not be treated as a real booking token without confirmation.
6. Confirm product data source and behavior for copy, track-order, and home actions. Do not infer destinations from labels.
7. Confirm IBM Plex Sans Arabic availability/approved substitution, and licensing/permission for any Figma-exported assets before adding them.
8. Confirm whether the 44 px root corner and status/home-indicator layers represent a device mockup or app viewport treatment.

## 10. Implementation checklist for Gemini

- [ ] Reopen the exact Figma node `3526:6123`; inspect its rendered screenshot and nested instances when MCP access is available. Keep this document's known values and resolve marked unknowns instead of guessing.
- [ ] Confirm whether implementation viewport is 402 ×1195 or an app viewport with system safe areas. Do not silently crop out the footer or treat Figma status/home-indicator art as live platform UI.
- [ ] Use the exact Arabic strings and typography metrics in section 3; confirm font mapping because IBM Plex Sans Arabic is not bundled.
- [ ] Build top-to-bottom hierarchy from section 2 and use the exact geometry/effects from section 5.
- [ ] Preserve Figma color values in section 4; do not mutate global theme tokens to accommodate this screen.
- [ ] Inspect/compare `store.svg`, `calendar.svg`, `done.svg`, and home candidates before reuse. Do not use arbitrary Material glyphs for missing copy, instruction, scissors, or QR assets.
- [ ] Obtain product decisions for dynamic data, QR payload, and CTA behavior before wiring any action or hard-coding sample values.
- [ ] Export only missing assets genuinely required after confirming authorization and licensing. Suggested paths are in section 6; follow existing asset organization and add attribution when required.
- [ ] Keep changes screen-scoped. This inspection did not authorize routing, model/API changes, shared-token changes, or edits to either precedent screen.
- [ ] After implementation, capture a runtime screenshot at the agreed viewport and compare to Figma; report mismatches and do not claim pixel-perfect without that evidence.

## Skill maintenance

`.agents/skills/ai-figma-feature/SKILL.md` was reviewed and already instructs hierarchy/property inspection, asset inventory/reuse, documenting failures, read-only inspection, and avoiding unsupported fidelity claims. No reusable workflow gap requiring a skill change was found, so the skill remains unchanged.
