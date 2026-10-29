# Selection Screen 02 — Delete confirmation overlay

- **Figma:** [node `1068:2733`](https://www.figma.com/design/OwhGcfZwmermbcH2L8rfUD/Waheed-Hassan--Copy-?node-id=1068-2733)
- **Name / parent:** `تأكيد الحذف` / section `472:6759`.
- **Canvas:** x=2275,y=100; **frame:** 402×874 px (verified metadata).
- **Status:** Partial. Context and screenshot reference returned. Screenshot reference was not visually reviewed or saved. Prototype transition is unknown.

## Visual hierarchy

The design context shows an account screen behind a dim/blur treatment, with a bottom sheet overlay. Background account content repeats the signed-in account structure in [Screen 01](SELECTION-SCREEN-01-ACCOUNT-SIGNED-IN.md); backdrop blur in generated context is 2 px, while the supplied style summary also exposes a background-blur effect token of radius 48. These are separate context observations; exact rendered blur binding needs verification.

Sheet `1068:2824` is at (0,424), 402×450. It has a centered 48×6 drag indicator at y=16, followed by content frame `1068:3097` at x=16,y=38,370×388. Warning illustration container 350×180 includes 80×80 icon. Title `تأكيد حذف الحساب` (node `1068:2841`) is followed by two-line warning: `سيتم حذف حسابك وجميع بياناتك بشكل نهائي ولا` / `يمكن استعادتها.` (node `1068:2842`, exact text from design context). Confirmation row `Label - Confirmation Checkbox` (370×56) contains `لقد فهمت أن هذا الإجراء نهائي.` and a checkbox icon. Action region is 370×120: `حذف الحساب` button 370×56 and `Component 8` instance 370×56 below it.

## Typography and properties

Context exposes title IBM Plex Sans Arabic SemiBold 24 px, line height 32 px, black; body IBM Plex Sans Arabic Regular 16 px, line height 26 px, `#444748`; checkbox label IBM Plex Sans Arabic Regular 14 px, line height 20 px, black. Sheet background white, top radii 32 px and shadow `0px 4px 4px 0px rgba(0,0,0,0.25)` are visible in returned design context. Warning surface uses `#FDECEC`, checkbox row `#F3F3F4`, radius 12 px. Remaining action colors/state, exact vector colors/export, and responsive behavior unknown.

The title/body/button imply a destructive confirmation but trigger and destination are not verified. Checkbox selected state and button enabled/disabled states are unknown. Screenshot reference was returned for node `1068:2733`; its short-lived URL is not stored as an asset.

## Durable extraction record

- Category-level status: extraction-archive/EXTRACTION-STATE.json.
- Node record: [1068-2733.json](extraction-archive/NODE-EXTRACTION-RECORDS/1068-2733.json).
- Registry: extraction-archive/SCREEN-REGISTRY.json.
- Reusable without another Figma call: the values already recorded in this specification may be reused with their current evidence labels. This partial record is not sufficient to claim full visual or behavior coverage; request new data only for categories marked partial/blocked in the archive state.
