# Figma Screen Specification — Choose Appointment (اختر الموعد)

## Handoff status

**Inspection complete; implementation not started.** Figma MCP inspection succeeded. Product decision: no appointment time is selected automatically on entry. The CTA reflects whether a valid time is selected, but remains static and inert in this node. Navigation and appointment-data handoff belong to the future, separate `تأكيد الطلب` screen. No live appointment data source was found in the current project; if temporary appointment data is needed before a real source exists, it must be explicitly identified as temporary and must not be represented as live availability. No Flutter source, Figma content, configuration, or project workflow files were changed.

## 1. Node identity and inspection method

- **Figma file key:** `OwhGcfZwmermbcH2L8rfUD`
- **Node ID:** `3526:5940`
- **Node name:** `اختر الموعد` (Choose Appointment)
- **Node type:** Frame
- **Verified dimensions:** 402 × 905 Figma units
- **Source URL:** [Waheed Hassan — Choose Appointment](https://www.figma.com/design/OwhGcfZwmermbcH2L8rfUD/Waheed-Hassan%E2%80%93Copy-?node-id=3526-5940&t=L9DnanED7laAtwN1-4)
- **Figma MCP methods:** `get_metadata`, `get_design_context` on the root and relevant date/time/branch/header/footer nodes, `get_screenshot`, and `get_variable_defs`.
- **Screenshot:** MCP returned a 402 × 905 PNG matching the node dimensions; the render was visually inspected.
- **Figma access limitation:** None for this node. The disabled footer variant and its exact visual tokens are not represented in the returned node/context; this is a design-data gap, not an MCP access failure.
- **Units:** Dimensions and coordinates below are Figma units. Fractional values are preserved where useful.

## 2. Screen purpose and verified hierarchy

This is an appointment-selection screen in the branch-pickup path. The captured state shows May 2026 dates, Wednesday 20 selected, 3:00 PM selected, three unavailable dates and two unavailable time slots, branch information, and the active “تأكيد الموعد” footer action.

```text
اختر الموعد — 3526:5940 (402 × 905)
├─ Main content — 3526:5941 (x 16, y 141, 370 × 494.893)
│  ├─ Date section — 3526:5943 (370 × 168.489)
│  │  ├─ Section heading/icon — 3526:5944 (370 × 22.489)
│  │  │  ├─ “اختر التاريخ” — 3526:5945/5946
│  │  │  └─ Calendar icon — 3526:5947 (15.982 × 15.982)
│  │  └─ Date card — 3526:5952 (370 × 134; y 34.489)
│  │     ├─ Month “مايو ٢٠٢٦” — 3526:5953
│  │     └─ Clipped horizontal date viewport — 3526:5954 (338 × 83.98)
│  │        └─ Date buttons for 17–30 May — 3526:5955–6046, each 55.993 × 79.984
│  ├─ Time section — 3526:6053 (x 0, y 184.489, 370 × 230.439)
│  │  ├─ Section heading/icon — 3526:6054 (370 × 22.489)
│  │  │  ├─ “اختر الوقت” — 3526:6055/6056
│  │  │  └─ Clock icon — 3526:6057 (15.982 × 15.982)
│  │  └─ Time card — 3526:6060 (370 × 195.963)
│  │     └─ Time grid — 3526:6061 (x 24, y 24, 322 × 147.963)
│  │        ├─ Row 1 — 3526:6062 (3 × 102 × 43.988 slots)
│  │        ├─ Row 2 — 3526:6069 (3 × 102 × 43.988 slots)
│  │        └─ Row 3 — 3526:6076 (3 × 102 × 43.988 slots)
│  └─ Branch information card — 3526:6083 (x 0, y 430.927, 370 × 63.965)
│     ├─ Branch title/subtitle — 3526:6084–6086
│     └─ Store/branch icon tile — 3526:6087/6088 (39.992 tile / 19.996 icon)
├─ Header — 3526:6094 (x 0, y 53, 402 × 64)
│  ├─ Cart component — 3526:6095, opacity 0 (not visible)
│  ├─ Title “اختر الموعد” — 3526:6096
│  └─ Back control — 3526:6097–6098 (48 × 48; arrow icon 24 × 24)
├─ Status/system bar — 3526:6099 (402 × 53)
│  ├─ Status indicators — 3526:6100 (66.662 × 11.336)
│  └─ Time label — 3526:6114/6115 (“9:41” in the render)
└─ Bottom action/system area — 3526:6116 (x 0, y 792, 402 × 113)
   ├─ Action container — 3526:6117 (402 × 80)
   │  └─ Active CTA frame — 3526:6118 (x 16, y 12, 370 × 56)
   │     └─ “تأكيد الموعد” — 3526:6119
   └─ Home-indicator area — 3526:6120/6121 (402 × 33)
      └─ Home indicator — 3526:6122 (139 × 5)
```

Main content begins 24 units below the header. Date and time sections are separated by 16 units. The date and time headers are right-aligned for Arabic/RTL. The branch card follows the time card after 16 units. Footer is fixed to the frame bottom in the design. The root uses a `#FAFAFA` background, `overflow-clip`, and a 44-unit corner radius in the Figma representation.

## 3. Verified Figma visual specification

### Root, system chrome, header, and footer

| Element | Figma values |
|---|---|
| Root frame | `#FAFAFA` (variable fallback `Background`); 402 × 905; clipped contents; 44 px radius. |
| Status/system strip | y 0–53, white with backdrop blur; design-context CSS representation says 24 px blur. Status time `9:41`, SF Pro Semibold 14 px, weight 590, line 16, tracking −0.28 px; system indicator art about 66.662 × 11.336. This is iOS-style mock chrome in the Figma frame. |
| Header | x 0, y 53, 402 × 64; white; 1 px bottom border using `Border` (`#EAEAEA`); horizontal padding 16, vertical padding 8. Center title “اختر الموعد”, IBM Plex Sans Arabic Medium 18 px, black. |
| Header cart | Figma Cart component exists at left but is fully transparent (opacity 0); it is not visible in the screenshot. |
| Back control | Right side in the RTL header; circular white control, 48 × 48, 1 px `#ECECEC` border, 99 px radius, shadow `0 1px 4px 1px rgba(0,0,0,0.06)`. 24 × 24 Vuesax `arrow-left` linear icon is rotated 180° in the Figma composition, appearing as a right-pointing chevron. |
| Footer | x 0, y 792, 402 × 113; white. CTA container 80 high with 1 px top border `#EAEAEA`, padding 16 horizontal / 12 vertical. 33 px home-indicator region follows, with black 139 × 5 rounded indicator. |
| Active CTA | x 16, y 804, 370 × 56; pure black `#000000`; radius 16; shadow `0 10px 7.5px rgba(0,0,0,0.1)` and `0 4px 3px rgba(0,0,0,0.1)`. Text “تأكيد الموعد”, IBM Plex Sans Arabic SemiBold 16 px / 24 px, white, centered. |

The target node supplies the **active CTA only**. The no-selection label “اختر وقتًا للمتابعة” and disabled-looking gray state are explicit product-owner requirements, but no disabled CTA node/variant, color, opacity, border, or shadow is exposed by this Figma node. Do not claim an exact disabled color from Figma. Existing `PrimaryButton` has its own disabled treatment (`AppColors.black` at 30% alpha, white 14 px Inter label), which does not establish the requested gray appearance and should not be reused unchanged as proof of a Figma match.

### Date selection

| Element | Figma values |
|---|---|
| Section header | “اختر التاريخ”; right-aligned; IBM Plex Sans Arabic SemiBold 15 px / 22.5 px; `Gary text` variable `#314158`; calendar icon about 16 × 16; icon/text gap about 8 px; 4 px trailing inset. Header-to-card gap 12 px. |
| Date panel | x 0, y 34.489 within section; 370 × 134; white; 16 px radius; 16 px padding; vertical internal gap about 12 px; shadow `0 1px 3px rgba(0,0,0,0.1)` and `0 1px 2px -1px rgba(0,0,0,0.1)`. |
| Month label | “مايو ٢٠٢٦”; IBM Plex Sans Arabic Regular 12 px / 16 px; `#62748E`; aligned to the right. |
| Date viewport | x 16 within panel; width 338, height 83.98; `overflow-clip`. Cards are about 56 × 80 with 8 px horizontal pitch gap; 16 px radius; 1.173 px border. The hierarchy lists dates 17–30 May; some are beyond the visible clipped window. |
| Unselected/available date | White fill; `#E2E8F0` border; weekday 10 px Medium / 15 px, day number 18 px Bold / 28 px, month 9 px Medium / 13.5 px; text `#0F172A` (weekday/month at 70% opacity). |
| Selected date | 20 May (Wednesday); `#314158` fill and border; white weekday/day/month; same typography as above, weekday/month at 70% opacity. |
| Unavailable-looking dates | 17 (Sunday), 18 (Monday), 19 (Tuesday); `#F8FAFC` fill, `#E2E8F0` border, 50% button opacity; text `#CBD5E1`, with weekday/month additionally at 70% opacity. They are visually disabled; the data does not state why they are unavailable. |

Visual chronological order is RTL: later dates proceed toward the left side of the clipped strip. In the captured viewport the visible run is approximately Friday 22 (partially clipped at far left), Thursday 21, selected Wednesday 20, then disabled Tuesday 19, Monday 18, Sunday 17 toward the right. Metadata also contains 23–30 May in the clipped sequence. The Figma design demonstrates clipped overflow but does not expose a gesture/scroll interaction or the carousel’s initial scroll offset rule.

### Time selection

| Element | Figma values |
|---|---|
| Section header | “اختر الوقت”; IBM Plex Sans Arabic SemiBold 15 px / 22.5 px; `#314158`; clock icon about 16 × 16; icon/text gap about 8 px. Header-to-card gap about 12 px. |
| Time panel | 370 × 195.963; white; 16 px radius; 24 px padding; shadow `0 1px 1.5px rgba(0,0,0,0.1)` and `0 1px 1px rgba(0,0,0,0.1)`. |
| Grid | 322 × 147.963; three columns × three rows; each cell 102 × 43.988; 8 px row and column gaps; 14 px radius; 1.173 px border `#E2E8F0`. |
| Available/unselected | White fill; IBM Plex Sans Arabic Medium 14 px / 20 px; text `#0F172A`. |
| Selected | 3:00 PM (`٠٣:٠٠ م`) in the middle cell of row 2; `#314158` fill; white text; border remains `#E2E8F0`. |
| Unavailable-looking | 12:00 PM (`١٢:٠٠ م`) at row 1 left and 6:00 PM (`٠٦:٠٠ م`) at row 3 right; `#F8FAFC` fill; text `#CBD5E1`, 14 px Medium / 20 px, strikethrough; `#E2E8F0` border. |

Rows as positioned left-to-right by Figma coordinates (semantic RTL reading is the reverse within each row):

1. `١٢:٠٠ م` (unavailable-looking) | `١١:٠٠ ص` | `١٠:٣٠ ص`
2. `٠٤:٣٠ م` | `٠٣:٠٠ م` (selected) | `٠١:٣٠ م`
3. `٠٩:٠٠ م` | `٠٧:٣٠ م` | `٠٦:٠٠ م` (unavailable-looking)

The node shows one date and one set of times together, but does not define a per-date schedule mapping, availability API, timezone, locale formatting algorithm, or whether a slot remains selected when switching dates. The sample times are not a live availability contract.

### Branch information card

- Bounds: x 0, y 430.927 within main content; 370 × 63.965.
- Surface: white, 16 px radius, padding 12 px, gap about 12 px, shadow `0 1px 1.5px rgba(0,0,0,0.1)` and `0 1px 1px rgba(0,0,0,0.1)`.
- Title: **“الفرع الرئيسي – ميت غمر”**, IBM Plex Sans Arabic SemiBold 14 px / 24 px, `#0A0A0A`, right-aligned.
- Subtitle: **“ميت غمر، شارع المعاهده بجوار كلية التربية النوعية”**, IBM Plex Sans Arabic Medium 10 px / 16 px, `#62748E`, right-aligned; 2 px vertical gap after title.
- Icon tile: right side of the row in RTL; 39.992 × 39.992, `rgba(30,58,138,0.06)` background, 14 px radius; centered 20 × 20 branch/store outline icon.
- The node does not expose a branch-change control.

## 4. Selection and CTA behavior contract

### Product-owner requirements (binding for implementation)

| Selection validity | CTA label | Enabled behavior | Appearance |
|---|---|---|---|
| No valid appointment (no time selected, or current date/time pair incomplete, unavailable, or invalid) | `اختر وقتًا للمتابعة` | Disabled and cannot be activated. | Disabled-looking gray is required by product decision; exact values are not available in this Figma node. |
| A valid date/time appointment is selected | `تأكيد الموعد` | Dark visual enabled state only. The button remains static: no `onPressed`/callback, navigation, API request, persistence, or order-confirmation behavior. | Active Figma state: black `#000000`, 370 × 56, radius 16, white IBM Plex Sans Arabic SemiBold 16/24, specified footer shadow. |

Required transitions:

1. Selecting an available date marks only that date selected.
2. Selecting an available time marks only that time selected and clears the prior time selection.
3. Unavailable-looking dates and slots cannot be selected.
4. CTA label, enabled semantics, and visual state are derived from the current valid appointment selection, not maintained as an independent flag.
5. On date change, revalidate the selected time against the options displayed for the new date. If the selected time is not available for that date, clear it and return to the no-valid-appointment CTA state. Preserve it only if the actual schedule data says that same time is still available for the newly selected date.
6. The CTA has no activation behavior in this node, including when its visual state is dark. The visual state reflects selection validity only; it does not submit or hand off the appointment.

### Initial selection policy — resolved

- **Figma snapshot:** date 20 May 2026 and time 3:00 PM are visibly selected; the footer is active.
- **Current app/product rules:** no appointment model, availability list, default slot policy, or appointment selection state exists.
- **Required initial state:** no appointment time is selected automatically. The selected date shown by the Figma snapshot does not imply a selected time. The CTA initially displays `اختر وقتًا للمتابعة`, looks disabled, and cannot be activated.
- Do not preselect the stale May 2026/3:00 PM visual sample as production data. If no real appointment source exists at implementation time, any fixture data used to render/exercise the screen must be clearly labeled temporary and must not imply live availability.

### Loading, empty, unavailable, and error states

- **Existing project behavior:** no appointment loading, empty, error, or retry flow exists in checkout.
- **Figma unavailable examples:** dates 17–19 May and time slots 12:00 PM and 6:00 PM are shown visually unavailable; no reason or rule is given.
- **Figma loading/error/empty examples:** none.
- **Implementation scope:** use the two requested CTA validity states and disabled option visuals. Do not invent loading/error screens or backend behavior. If no real availability source is available, temporary sample data may be used only when clearly labeled as temporary, never as live availability. Product owner must identify the real availability source and any async-state requirements before those states are added.

## 5. Pickup entry condition, branch state, and existing flow

### Verified current flow

- `CheckoutScreen` starts with `ReceivingMethod.deliveryToHome`.
- `ReceivingMethodSection` switches between `deliveryToHome` and `pickupFromBranch` through local `setState`.
- Selecting pickup currently leaves the user on `CheckoutScreen` and displays `PickupDetailsSection`; it does not navigate to an appointment screen.
- `_selectedBranch` is initialized to `BranchModel.defaultBranch`; there is no branch picker/change callback in checkout or the inspected branch card.
- `CheckoutScreen._onSubmitOrder` pushes `OrderReviewScreen` after validating cart/address/payment. It does not pass `_selectedBranch` to `OrderReviewArgs` even though `OrderReviewArgs.branch` is optional. The order-review branch card only renders when that argument is non-null.
- Current `OrderReviewScreen._onConfirmOrder` has a TODO for a real order repository, waits two seconds, and pushes `SuccessScreen` with placeholder order number `EQ-000000` and a fixed delivery estimate. That is order completion; it does not define what appointment confirmation should do.
- `.ai/state/success-screen-implementation-handoff.md` says the order-review navigation update is pending, but current source now contains the `Navigator.push` to `SuccessScreen`; the source was treated as authoritative and the handoff was not changed.

### Entry and branch data guidance

- **Required condition:** show this screen only in the `pickupFromBranch` path. Keep `deliveryToHome` on its existing address/delivery-method flow.
- **Likely current entry point:** the pickup option in `ReceivingMethodSection`. Current code only toggles inline content; product owner should confirm whether selecting pickup opens scheduling immediately or whether an explicit continue action should open it.
- **Branch data:** display the supplied/current `BranchModel` (`name`, `address`) rather than hardcoding Figma’s example. Current available instance is `BranchModel.defaultBranch` (“الفرع الرئيسي - ميت غمر”, same address); its name uses a hyphen where Figma copy uses an en dash. There is currently no way to choose another branch.
- **Required branch decision:** confirm whether this task should use the current default branch or whether a separate branch-selection flow/data source will exist before scheduling. Do not add a branch selector without approval.
- **After “تأكيد الموعد” (resolved for this node):** no action occurs; the button remains static in both visual states. Do not add `onPressed`, callback, navigation, API call, persistence, or order-confirmation logic. A future separate `تأكيد الطلب` screen/node will define navigation and appointment-data handoff. That is a future integration point, outside this node’s implementation scope. Do not send this action to `SuccessScreen` or add appointment fields to `OrderReviewArgs` as part of this screen.

## 6. RTL, safe areas, and responsive behavior

- Root/content and visible labels are Arabic-first and RTL. Preserve Arabic shaping, right alignment, logical reading/focus order, and localized accessibility labels.
- Date strip is laid out with later dates moving left in the visible viewport. Time rows use three equal-width slots; preserve the captured RTL order rather than sorting labels as LTR text.
- Figma explicitly clips the root and the horizontal date viewport. Horizontal swiping is not explicitly encoded, although offscreen dates 23–30 and clipping suggest a scrollable date strip. Confirm whether date-strip scrolling is required; the current project has no date strip behavior to reuse.
- No other viewport/breakpoint behavior is supplied. Main target is 402 × 905. On smaller displays the content should remain usable without overlapping the fixed footer; use Flutter constraints/scrolling consistent with existing checkout (`Expanded` + `SingleChildScrollView`) if needed, without inventing another breakpoint.
- Figma includes a 53 px iOS-style status/system strip and a 33 px home-indicator region. In Flutter, use platform status/navigation bars and `MediaQuery` safe-area insets; do not draw duplicate status/home indicators unless this screen is intentionally rendered inside a mock-device canvas. The footer should remain above the actual system bottom inset.
- The Figma root’s 44 px radius may describe the device/frame preview. Confirm whether it belongs in the app route; do not wrap a normal app screen in a 44 px clipping card without approval.

## 7. Existing architecture, tokens, widgets, and assets reviewed

Project guidance reviewed: `.ai/project/ARCHITECTURE.md`, `ARCHITECTURE-POLICY.md`, `DESIGN-SYSTEM.md`, `CORE-CONFIGURATION.md`, `UI-FLOWS.md`, `PRODUCT-RULES.md`, and `RESOURCE-ROUTING.md`; `.agents/rules/00-ai-engineering-core.md`; `docs/ARCHITECTURE.md`; the Figma feature skill; previous SuccessScreen spec and implementation handoff.

Architecture is the Minimal feature-based Flutter/Dart profile. Keep local selection state simple (`setState` unless review identifies a real shared-state need); do not introduce a provider, repository, API, DI, global token, or Core change for this screen. Existing file-size target is 400 lines.

Relevant existing files inspected:

- `lib/features/checkout/checkout_screen.dart` — method selection, branch default, current order-review entry.
- `lib/features/checkout/widgets/receiving_method_section.dart` — `ReceivingMethod` and pickup/delivery controls.
- `lib/features/checkout/widgets/pickup_details_section.dart` — current branch display; includes a section header and a different card treatment than this Figma card.
- `lib/features/checkout/models/branch_model.dart` — only `name`, `address`, and `defaultBranch`; no selected appointment data.
- `lib/features/checkout/order_review_screen.dart` — current order confirmation flow; no appointment handling.
- `lib/features/checkout/widgets/checkout_bottom_bar.dart`, `primary_button.dart` — existing bottom/button patterns and disabled styles; neither expresses the requested appointment CTA states exactly.
- `lib/features/checkout/widgets/checkout_section_header.dart` — reusable section heading pattern (currently 20 px icon, Inter 15 px w800).
- `lib/core/widgets/app_back_button.dart` — reusable circular back button, 44 × 44 with 16 × 16 local icon.
- `lib/core/widgets/app_image.dart` — local SVG asset renderer.
- `lib/app/theme/app_colors.dart`, `app_text_styles.dart` — shared tokens/styles.
- `lib/main.dart` — Arabic locale is the default; Arabic and English locales are supported.
- `test/widget_test.dart` is the only existing test file; there is no checkout feature test directory today.

### Token and asset mapping

| Figma value | Existing project match / note |
|---|---|
| Background `#FAFAFA` | Exact `AppColors.background`. |
| White surface `#FFFFFF` | Exact `AppColors.white` / `surface`. |
| `Gary text` `#314158` | Exact `AppColors.navy`. |
| `#E2E8F0` | Exact `AppColors.divider` / `inactive`. |
| `#F8FAFC` | Exact `AppColors.surfaceSubtle`. |
| Border `#EAEAEA` | Closest shared border is `AppColors.border #ECECEC`, not exact. Do not alter a global token for this screen. |
| Text `#0F172A`, `#0A0A0A`, `#62748E`, disabled `#CBD5E1`, CTA pure black `#000000` | Not exact matches in `AppColors`; app primary black is `#111111`, secondary text `#8F8F8F`, slate `#94A3B8`, hint `#BFC6D0`. Use local screen values or request token approval if needed for fidelity; do not change global colors. |
| Branch tile `rgba(30,58,138,0.06)` | No dedicated shared token. |
| Typography | Figma specifies IBM Plex Sans Arabic, but that font is not bundled. Cairo is the project’s documented Arabic body font; the owner approved Cairo as the feature-scoped substitute. Shared `AppTextStyles` remain Inter-based, so the dedicated style class derives matching size/weight styles where possible and applies Cairo and Figma metrics locally. This does not claim IBM Plex font equivalence. |
| Back control | The shared `AppBackButton` is 44 × 44 with a 16 × 16 icon; Figma specifies 48 × 48 and a 24 × 24 rotated arrow. A dedicated Choose Appointment back control uses the existing arrow asset and shared colors with those local dimensions; the global component remains unchanged. |
| Branch icon | `assets/icons/store.svg` is the local Tabler `building-store` outline icon used for the Figma storefront. Its source attribution and complete MIT notice are in `THIRD_PARTY_NOTICES.md`; byte identity with upstream is not claimed. |
| Calendar/clock icons | `assets/icons/calendar.svg` and `assets/icons/clock.svg` provide the Figma outline icons at 16 × 16. Their per-file Tabler attribution and the complete MIT notice are in `THIRD_PARTY_NOTICES.md`; byte identity with upstream is not claimed. |
| Branch/date/time components | Figma date/time buttons are frames; no variant/property definitions are exposed. The header contains a Cart instance at opacity 0 and a Vuesax `arrow-left` linear component. No Code Connect mapping is present in the inspected output. |

### Architecture compliance review follow-up

`.agents/rules/00-ai-engineering-core.md` rule 4 directs screens to shared `AppColors` and `AppTextStyles` and prohibits inline color/font specs. The product owner approved feature-scoped exceptions for this screen. The exceptions are centralized in `lib/features/checkout/utils/choose_appointment_styles.dart` and the local back control in `lib/features/checkout/widgets/choose_appointment_back_button.dart`; the global theme, shared tokens, shared widgets, and Core are unchanged.

| Scoped exception | Figma/project conflict and reason |
|---|---|
| Arabic typography | Figma specifies IBM Plex Sans Arabic, which is not bundled. Project rules document Cairo for Arabic body text, while all `AppTextStyles` are Inter. The feature-scoped styles derive from `AppTextStyles` where the size/weight pattern matches and locally apply Cairo, Figma line heights, or one-off metrics. This is a documented substitute, not an exact IBM Plex match. |
| Colors | Figma `#EAEAEA`, `#62748E`, `#0A0A0A`, `#0F172A`, `#CBD5E1`, `rgba(30,58,138,0.06)`, pure black `#000000`, and shadow alpha values have no exact shared color/shadow token. They remain local in the feature style class to avoid changing global tokens. Exact matches such as background, white surfaces, navy, date/slot inactive surfaces, and the disabled CTA’s product-approved gray continue using `AppColors`. |
| Text metrics | Month/date/branch/time labels and the header title have sizes, weights, or line heights without exact `AppTextStyles` equivalents. The feature styles start from the nearest existing style and override only the Figma-required properties. |
| Back control | `AppBackButton` is 44 × 44 with a 16 × 16 arrow, versus Figma’s 48 × 48 control and 24 × 24 rotated arrow. A dedicated control is necessary for the node’s measured dimensions and visual orientation. It reuses the existing arrow asset, `AppImage`, and shared surface/border colors; no shared component is changed. |
| Disabled CTA | Figma exposes only the active variant. The initial disabled-looking state comes from product requirements; the implementation therefore uses the closest existing `AppColors.divider` and `textSlateSecondary` tokens rather than presenting the gray values as Figma-verified. The CTA remains inert in both states. |

No font was added and no global token/theme/Core change was made. The local styles are limited to Choose Appointment and its dedicated widgets.

### Figma variable definitions returned

`Gary text = #314158`; `White = #FFFFFF`; `Border = #EAEAEA`; `System/Label/Secondary = #3C3C4399`; `System/Label/Primary = #000000`; `System/Black [Dynamic] = #000000`; `Background = #FAFAFA`; and `Blur/System Material = BACKGROUND_BLUR radius 48`. The blur variable reports radius 48 while the node's generated CSS representation reports `backdrop-blur-[24px]`; treat these as two values returned through different representations and ask design/architecture review which rendering value to follow if the distinction affects implementation.

## 8. Implementation scope and integration boundaries

1. `lib/features/checkout/pickup_scheduling_screen.dart` owns this feature screen and its local selection state/layout. The date strip and time grid are dedicated checkout widgets; do not add generic Core widgets. The appointment CTA has no activation callback in either selection state.
2. `lib/features/checkout/checkout_screen.dart` enters this screen only through the approved `pickupFromBranch` action and passes the current branch. Preserve the existing home-delivery path unchanged. This entry navigation is separate from the inert appointment CTA.
3. `lib/features/checkout/utils/choose_appointment_styles.dart` contains approved feature-scoped text/color/effect exceptions. `lib/features/checkout/widgets/choose_appointment_back_button.dart` matches the node's 48 × 48 control and 24 × 24 arrow without changing the shared component.
4. Focused tests live in `test/features/checkout/`: selection, CTA validity/inertness, unavailable choices, date/time synchronization, branch rendering, back-control dimensions, and positive home-delivery routing to Order Review.
5. Do **not** modify `BranchModel`, `OrderReviewArgs`, or `OrderReviewScreen` appointment fields/navigation until the product owner defines the availability source and the appointment-confirmation result/destination. If review determines these are needed, list them as a separately approved integration scope before coding.
6. Reuse `BranchModel`, `AppImage`, `AppColors`, and `AppTextStyles` where they match. Do not edit global `AppColors`, `AppTextStyles`, shared Core widgets, dependencies, or unrelated checkout behavior.

## 9. Open decisions / assumptions requiring product-owner review

1. **Initial state — resolved:** no appointment time is automatically selected. Figma’s May 20 / 3:00 PM selection documents the active visual state only; it is not a production default.
2. **Availability source and rules:** source for dates/times, refresh/loading/error behavior, timezone, expiry, and rules that make dates/slots unavailable are absent. Do not treat the sample May 2026 values as production data. If no real source is available, any data used must be clearly documented as temporary sample data and not live availability.
3. **Date/time relationship:** the visual pairs one selected date with one time grid, but no per-date slot mapping is specified. Confirm whether choices are reloaded per date and whether an unchanged time is preserved when it remains available.
4. **Entry timing:** current pickup selection changes inline content only. Confirm whether tapping “استلام من الفرع” should push this screen immediately or whether another explicit continue action opens it.
5. **Future integration point:** the separate `تأكيد الطلب` node must define navigation and appointment-data handoff. In this node, `تأكيد الموعد` remains inert even when visually dark; no action, route, service call, or persistence is in scope. Current SuccessScreen navigation is order confirmation and is not a valid inferred appointment destination.
6. **Branch selection:** current branch is the hardcoded default model and no branch-change UI exists. Confirm whether default branch is sufficient or a separate branch-choice flow is needed.
7. **Disabled CTA style:** the required gray appearance and label are specified by product owner, but the supplied Figma node includes only the black active CTA. Provide/approve exact disabled colors, opacity, border, and shadow if a precise match is required.
8. **Date-strip scrolling and frame corners:** confirm whether clipped dates are swipe-scrollable and whether Figma’s 44 px root radius is a device mockup treatment.
9. **Typeface and icon assets — resolved within this feature:** IBM Plex Sans Arabic is not bundled; Cairo is the approved local Arabic substitute under the feature-scoped styling exception. Calendar, clock, and storefront SVGs have per-file attribution and a complete MIT notice in `THIRD_PARTY_NOTICES.md`; byte-for-byte upstream identity is not asserted. No dependency or global design-system change is in scope.

## 10. Acceptance criteria for implementation

These are testable requirements; use an existing real appointment source if one becomes available. Otherwise, fixtures are temporary sample data and must be labeled as such, not treated as live availability or production scheduling rules.

- [ ] On initial entry, no appointment time is automatically selected. The CTA reads `اختر وقتًا للمتابعة`, is semantically disabled, uses the approved disabled-looking gray appearance, and cannot be activated.
- [ ] Given an available date and available time are shown, selecting a time marks that slot with the selected dark treatment and white label; the CTA label/visual state changes to dark `تأكيد الموعد` only when the date/time pair is valid. Its visual enabled appearance does not create an action handler.
- [ ] Selecting a second available time clears the previous selected time; exactly one slot is selected.
- [ ] Unavailable date and time options cannot be selected; they retain disabled styling and disabled semantics.
- [ ] When date changes, if the current time is not available for the new date, the time selection clears and the CTA returns to disabled label/state. If the same time is valid for the new date, selection retention follows the approved product rule and the CTA remains valid.
- [ ] The disabled CTA cannot be activated. After valid time selection, the dark `تأكيد الموعد` CTA remains inert: no `onPressed`/callback, navigation, API call, persistence, or order-confirmation behavior occurs, even if the underlying button widget normally requires a callback.
- [ ] CTA label and visual state stay synchronized with selection validity after selecting/changing dates or times. The control cannot be activated in either state; expose the label/state accessibly without advertising an actionable button when selected.
- [ ] The branch card shows the current supplied branch name/address rather than a hardcoded example. With the existing default branch, it shows the current branch model values.
- [ ] Choosing `pickupFromBranch` can reach the scheduling screen via the approved entry point; choosing `deliveryToHome` continues through the existing address/delivery-method UI and does not open scheduling.
- [ ] Arabic labels remain RTL and legible; date-strip and time-slot visual order matches the Figma RTL arrangement.
- [ ] The page and fixed footer remain usable at the 402 × 905 target and a smaller supported viewport without obscuring content or the actual system safe area.
- [ ] The final runtime screenshot is compared with the Figma screenshot at a matching viewport. Report mismatches; do not claim pixel-perfect without comparison evidence.

## 11. Validation results and remaining visual check

- `flutter test --reporter expanded test/features/checkout/` — exit 0; all 22 focused checkout tests passed, including selection, routing, CTA inertness, and local back-control dimensions.
- `flutter analyze` — exit 1 with two info-level findings: `prefer_final_fields` at `lib/features/checkout/checkout_screen.dart:37` and `depend_on_referenced_packages` at `lib/main.dart:2`. No analyzer errors were reported.
- `flutter test` — exit 1 because unchanged `test/widget_test.dart:19` expects counter text `0`, which the current app does not render. All checkout tests passed in the same run.
- Pixel-level visual validation remains pending: no rendered implementation screenshot was captured and compared with Figma. Render at 402 × 905 and a smaller supported height before making any pixel-fidelity claim.

### Remaining visual comparison checklist

- Render at 402 × 905 and a smaller supported height; compare hierarchy, spacing, Arabic rendering, selected/disabled styles, footer placement, safe areas, and icons against the MCP screenshot.
- Report mismatches. No pixel-level fidelity claim is supported until an actual implementation screenshot is compared with Figma.
- The future order-confirmation node must specify and validate navigation and appointment-data handoff; the appointment CTA stays inert here.


## 12. Skill maintenance

`.agents/skills/ai-figma-feature/SKILL.md` already covers Figma MCP inspection, hierarchy, design properties/states, asset reuse, read-only safety, project mapping, handoff, and visual validation. This task did not reveal a reusable process gap, so the skill was left unchanged.
