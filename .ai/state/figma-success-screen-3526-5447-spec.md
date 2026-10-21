# Figma Screen Specification — SuccessScreen

## Handoff status

**Inspection complete; implementation not started.** This specification is ready for Antigravity to review against the Flutter architecture before OpenCode + Big Pickle implement it. No application code, Figma content, or configuration was changed during this inspection.

## Source and method

- **Figma file key:** `OwhGcfZwmermbcH2L8rfUD`
- **Node ID:** `3526:5447`
- **Node name/type:** `SuccessScreen` / frame
- **Frame dimensions:** 401 × 874 Figma units
- **Source URL:** [Waheed Hassan — SuccessScreen](https://www.figma.com/design/OwhGcfZwmermbcH2L8rfUD/Waheed-Hassan%E2%80%93Copy-?node-id=3526-5447&t=L9DnanED7laAtwN1-4)
- **Inspection:** Figma MCP `get_metadata` (already completed at the checkpoint), `get_design_context`, `get_screenshot`, and `get_variable_defs`; visual render reviewed. The screenshot response reports 401 × 874 PNG, matching the node dimensions.
- **Hierarchy evidence:** Figma metadata and design-context output. Positions and sizes below are Figma units; fractional values are retained from the response.

## Screen summary

An Arabic, right-to-left order confirmation screen. It presents a success mark, confirmation and shipping copy, an order number and delivery estimate, then two bottom actions: track the order and return home. The frame is white with pale navy and gold decorative circles clipped at opposite edges.

## Verified hierarchy and geometry

Root frame `3526:5447` (`SuccessScreen`): **401 × 874**, white fill (`#FFFFFF`). The design-context output describes a full-size relative root; its direct children are positioned relative to this frame.

```text
SuccessScreen (401 × 874, white)
├─ Container 3526:5448 — decorative circle (x 224.8, y -80, 256 × 256)
├─ Container 3526:5449 — decorative circle (x -80, y 636.8, 256 × 256)
├─ Frame 1410125686 3526:5450 — centered content (x 32.4, y 149.84, 336.8 × 369.125)
│  ├─ Container 3526:5451 — success emblem (128 × 128)
│  │  ├─ iconsax-tick-circle 3526:5452 — icon viewport (64 × 64)
│  │  │  └─ Clip path group 3526:5453 / Group 3526:5456 — SVG/mask artwork
│  │  └─ Container 3526:5458 — gold circular check badge (40 × 40; x -8, y 96)
│  │     └─ Icon 3526:5459 — artwork (20 × 20)
│  └─ Frame 1410125685 3526:5461 — message and order card (336.8 × 217.125); vertical gap 32
│     ├─ Container 3526:5462 — heading and body (295.462 × 66.75); vertical gap 8
│     │  ├─ Text 3526:5463 — confirmation heading
│     │  └─ Text 3526:5464 — explanatory sentence
│     └─ Container 3526:5465 — order information card (336.8 × 118.375)
│        ├─ Paragraph 3526:5466 / Text 3526:5467 — order-number label
│        ├─ Text 3526:5468 — order number
│        └─ Container 3526:5469 — dashed divider and delivery estimate
│           ├─ truck-fast instance 3526:5470 — 16 × 16 (component reference `408:23276`)
│           └─ Text 3526:5471 — delivery estimate
└─ Container 3526:5472 — bottom actions (x 0, y 643.8, 400.8 × 144); horizontal padding 20, gap 8
   ├─ Button frame 3526:5473 — primary action (360.8 × 56)
   │  ├─ truck-fast instance 3526:5474 — 20 × 20 (component reference `408:23276`)
   │  └─ Text 3526:5475 — “تتبع الطلب”
   └─ Button frame 3526:5476 — secondary action (360.8 × 56; y 64)
      └─ Text 3526:5477 — “العودة للرئيسية”
```

The content group uses a centered vertical column with 24 between the 128 × 128 emblem and the message/card group. The second group fills the 336.8-unit width. Its heading/body block is centered as text, while the order card content is arranged as label, order value, and delivery row. The bottom actions sit separately near the bottom edge; they are not part of the centered content group.

## Verified visual and style details

| Element | Verified values |
|---|---|
| Root | `#FFFFFF`; 401 × 874. No root corner radius or border is present in the metadata/context properties. |
| Upper decoration | 256 × 256 circle, x 224.8 / y -80, `#1E3A8A` at 10% opacity; extends beyond top/right bounds. |
| Lower decoration | 256 × 256 circle, x -80 / y 636.8, `#C9A961` at 10% opacity; extends beyond left/bottom bounds. |
| Main success emblem | 128 × 128 circle; linear gradient at 135° from `rgb(69, 90, 100)` (`#455A64`) to `rgb(0, 0, 0)` (`#000000`). |
| Tick artwork | 64 × 64 viewport, centered with a small -0.4 x / +0.16 y offset in the context representation; nested masked SVG artwork. Screenshot shows a dark check inside a white circular field. Exact SVG fill/stroke colors are not described in the text response. |
| Gold badge | 40 × 40 circle, `#C9A961`, positioned x -8 / y 96 relative to the emblem; 20 × 20 SVG icon. Shadow: `0 10px 7.5px rgba(0,0,0,0.1)` and `0 4px 3px rgba(0,0,0,0.1)`. |
| Heading | “تم تأكيد طلبك بنجاح”; IBM Plex Sans Arabic Bold, 24 px, 36 px line height, `#0F172B`, centered, RTL/auto direction. Text box 295.462 × 35.75. |
| Supporting copy | “شكراً لاختيارك متجرنا. سنرسل لك إشعاراً عند شحن طلبك”; IBM Plex Sans Arabic Regular, 14 px, 22.75 px line height, `#62748E`; single-line, no wrap in the design-context representation. |
| Order card | 336.8 × 118.375; `#F8FAFC` fill; `#F1F5F9` solid border 0.8 px; 16 px corner radius. |
| Order label | “رقم الطلب”; IBM Plex Sans Arabic Regular, 12 px / 16 px line height, `#62748E`; centered in its 303.2 px content region, at about 16 px inset from card top/side. |
| Order number | `EQ-815069`; IBM Plex Sans Arabic Bold, 16 px / 24 px line height, `#292D32`, 1 px letter spacing; centered. |
| Delivery row | Dashed top divider, `#E2E8F0`, 0.8 px; row content inset about 16 px; 16 × 16 `truck-fast` instance and Arabic estimate “التوصيل المتوقع: ٣–٥ أيام عمل” in IBM Plex Sans Arabic Regular, 12 px / 16 px, `#62748E`. |
| Primary action | 360.8 × 56; black fill (`#000000` in context); 16 px radius; shadow `0 10px 7.5px rgba(0,0,0,0.1)` and `0 4px 3px rgba(0,0,0,0.1)`; white “تتبع الطلب”, IBM Plex Sans Arabic SemiBold, 16 px / 24 px; 20 × 20 `truck-fast` instance. |
| Secondary action | 360.8 × 56; 0.8 px solid border `rgba(30,58,138,0.19)`; 16 px radius; label “العودة للرئيسية”, IBM Plex Sans Arabic SemiBold, 16 px / 24 px, black (`var(--black, black)`; the variable lookup also returned `Black: #000000`). No separate fill was specified in context. |

### Text content and layout details

- The order card starts at x 32.4 / y 400.5875 relative to the screen (the card’s y is 98.75 within the message/card group, itself beginning at y 301.8375).
- Its content region is 303.2 wide with approximately 16.8-unit side insets. The header/label region is 295.462 wide and sits centered in the card group.
- A dashed divider separates the order ID from the delivery estimate.
- The bottom action container spans x 0–400.8, starts at y 643.8, and has 20-unit horizontal padding. Button one begins at y 643.8; button two at y 707.8. The container ends at y 787.8, leaving 86.2 units to the 874-unit frame bottom.
- Text is marked `dir="auto"` in context. The screen and visible content are Arabic/RTL; keep Arabic text shaping and direction correct, while the mixed Latin/digit order code remains legible.

## Assets and component references

- Figma uses masked SVG artwork for the central tick and a separate SVG for the gold badge check. Their exact asset URLs are temporary MCP URLs and should not be used in app code.
- Both delivery/tracking icons are Figma `truck-fast` instances referencing component node `408:23276`; their displayed sizes are 16 × 16 and 20 × 20. The visual render shows the card icon in gold and the primary-action icon in white, but the text response does not expose the source vectors’ exact color values.
- Local candidates observed in the project are `assets/icons/truckfast.svg` and `assets/icons/done.svg`. `truckfast.svg` is 20 × 20 and uses `#292D32`; it is not a verified exact match for both Figma color contexts. `done.svg` is a white 24 × 24 tick-circle. Treat these as candidates only; compare their rendered geometry/colors to the Figma assets before reuse. No assets were downloaded.
- The `Button` nodes are reported as frames, not as component instances. The Figma hierarchy does not expose button variant/property definitions for them.

## Project architecture and implementation notes

Repository guidance reviewed: `.ai/project/ARCHITECTURE.md`, `ARCHITECTURE-POLICY.md`, `DESIGN-SYSTEM.md`, `CORE-CONFIGURATION.md`, `UI-FLOWS.md`, `TECH-STACK.md`, `RESOURCE-ROUTING.md`, plus `docs/ARCHITECTURE.md` and the Figma feature workflow skill. The project is Flutter/Dart with a feature-based structure; checkout-related screens/widgets live under `lib/features/checkout/`, shared tokens are in `lib/app/theme/`, and navigation is imperative with `Navigator`. Existing UI flow currently documents cart → checkout → address → order review, without this success frame.

The screen logically belongs to the checkout/order-completion flow. Antigravity should decide the exact feature file and navigation integration after architecture review; this inspection does not prescribe or create source files. Preserve the existing feature-based architecture and use `AppColors` / `AppTextStyles` where accurate matches exist. The Figma values differ from several existing tokens (for example root white vs app background `#FAFAFA`; primary heading `#0F172B` vs app text `#111111`; supporting text `#62748E` vs `#8F8F8F`/`#94A3B8`). Do not silently substitute a near token if fidelity requires a new/local style; Antigravity should decide whether a local screen style or token proposal is appropriate.

Figma specifies **IBM Plex Sans Arabic**. The project currently declares Inter and Cairo fonts in `pubspec.yaml`; the inspected font assets do not include IBM Plex Sans Arabic. Cairo is the closest existing Arabic-family option, but it is not the verified Figma typeface. Resolve this typography mapping during architecture review; do not add a font or dependency as part of this specification task.

## States, behavior, and responsive limits

**Verified:** the static success content and two action labels are visible in the default render. The primary action is visually filled black and the secondary is outlined.

**Not exposed by this node:** pressed, focused, hover, loading, disabled, or selected variants; button navigation destinations/callback behavior; dynamic order-number/delivery data contract; accessibility semantics; breakpoint rules; behavior on other viewport sizes. The 401 × 874 frame and its coordinates are the only verified layout target. Do not infer fixed-device behavior or button actions from labels alone.

## Verified values vs. uncertainty

Verified values come from Figma metadata/context or the screenshot. Inferences are explicitly limited to the description that this is an order-completion/success state, based on its visible title and content. Colors in the design-context output are exact where specified; sampled-looking screenshot colors are not promoted to exact values. The only variable definition returned by Figma was `Black = #000000`.

Unresolved implementation details:

1. Exact icon SVG fills/path geometry for the two success/check assets and color variants of `truck-fast`; local candidates are not yet confirmed exact matches.
2. Button tap destinations and whether the order number/estimate are dynamic or fixed sample content.
3. Figma’s behavior at different viewport sizes and platform safe-area handling; neither is specified by this frame.
4. Typeface delivery/mapping: IBM Plex Sans Arabic is specified by Figma but absent from the currently declared project font families/assets.
5. The screenshot visually shows a rounded outer viewport boundary, while root metadata/context provides no root corner radius. Do not add one based on the render alone.

## Visual-validation checklist for implementation handoff

- [ ] Render at 401 × 874 and compare against the Figma screenshot; record the comparison. Do not describe the result as pixel-perfect without this runtime comparison.
- [ ] Verify the root white surface, edge-clipped decorative circles, their positions, colors, and opacity.
- [ ] Verify emblem gradient, check artwork, gold badge size/overlap, and shadow.
- [ ] Verify content group placement, dimensions, 24/32/8 gaps, and card geometry.
- [ ] Verify Arabic text, IBM Plex Sans Arabic mapping decision, font weights/sizes/line heights/colors, RTL alignment, and mixed Latin order code.
- [ ] Verify order card fill, 0.8 px border, 16 px radius, dashed divider, delivery row, and order content.
- [ ] Verify both button bounds, gap, radius, border/fill, shadows, labels, and icon color/geometry.
- [ ] Confirm action behavior, order data source, and safe-area/layout behavior with the product flow owner; test any states that become defined.
- [ ] Confirm any reused local SVGs are visually exact in each slot before implementation is considered complete.
