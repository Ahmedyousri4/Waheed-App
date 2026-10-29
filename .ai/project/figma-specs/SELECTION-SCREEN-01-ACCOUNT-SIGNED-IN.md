# Selection Screen 01 — Signed-in account

- **Figma:** [node `1068:2903`](https://www.figma.com/design/OwhGcfZwmermbcH2L8rfUD/Waheed-Hassan--Copy-?node-id=1068-2903)
- **Name / parent:** `الحساب - مستخدم` / section `472:6759`.
- **Canvas:** x=1410, y=100; **frame:** 402×1106 px (verified metadata).
- **Status:** Partial. Metadata and design context returned; screenshot request was quota-blocked. No prototype edges verified.

## Hierarchy, top to bottom

1. System bar at (0,0), 402×53; right-side system glyph group; time area at x=21,y=16,54×21.
2. Header at y=53, 402×64: cart instance at x=16,y=8,48×48; centered `حسابي` (node `1068:2996`, 46×27, x=178,y=18.5); back-arrow instance in frame `1068:2997` with arrow instance `1068:2998`.
3. Main content frame `1068:2904`, x=16,y=125,370×799. Profile block `1068:2905` (96×151): Avatar instance `1068:2906`, x=8,y=16.5,80×80; name `أحمد محمد` (`1068:2907`) at y=104.5,96×30.
4. Menu region `1068:2908`, 370×632, y=167 within main content. Rows in order: edit profile `تعديل الملف الشخصي` with profile icon; language `اللغة` / value `الإنجليزية` with vector and chevron; favorites `المفضلة` with heart; orders `طلباتي` with box; help `مركز المساعدة` with headphone icon. Settings group rows are 48 px tall and separated by line layers; observed x positions/paddings are in source metadata, but exact Auto Layout/constraints were not exposed in retained context.
5. Legal group at y=340 relative to `Frame 152`, 370×128: `الشروط والأحكام`, divider, `سياسة الخصوصية`; each with vector icon.
6. Delete-account group at y=484, 370×68: `حذف الحساب` with trash icon and a leading chevron-like frame.
7. Logout row `تسجيل الخروج`, node `1068:2988`, x=0,y=584,370×48, logout icon 24×24.
8. Bottom navigation instance (`1068:3017`) in group y=1010, 402×81, plus home-indicator container y=1073,402×33 and pill 139×5.

## Text, appearance, assets, and behavior

Exact visible Arabic labels above are layer names/text returned by metadata. Design context reports IBM Plex Sans Arabic styles: Body1 Medium 16/500, Body1 Regular 16/400, Body2 Regular 14/400, line-height 100%, tracking 0; black `#1B1B1B`, white `#FFFFFF`, light gray `#EEEEEE`. Per-layer bindings, remaining colors, radii, strokes, effects, text alignment/direction, and wrapping are **not exposed/retained**; do not assign these styles to each label without checking.

Icons are mixed Figma instances/vectors/frames (profile, language, heart, box, help/headphone, legal, trash, logout, cart, back). Exact SVG/vector export names and matches to local `assets/icons/` are unknown. No image export verified.

Clickable-looking rows and back/cart/nav controls are visual affordances only. Destinations, triggers, selected states, and back behavior are unknown; no route is verified. See [flow](SCREEN-FLOW.md), [assets](ASSET-INVENTORY.md), and [component inventory](COMPONENT-INVENTORY.md).

## Durable extraction record

- Category-level status: extraction-archive/EXTRACTION-STATE.json.
- Node record: [1068-2903.json](extraction-archive/NODE-EXTRACTION-RECORDS/1068-2903.json).
- Registry: extraction-archive/SCREEN-REGISTRY.json.
- Reusable without another Figma call: the values already recorded in this specification may be reused with their current evidence labels. This partial record is not sufficient to claim full visual or behavior coverage; request new data only for categories marked partial/blocked in the archive state.
