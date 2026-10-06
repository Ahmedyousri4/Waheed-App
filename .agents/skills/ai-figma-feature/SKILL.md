---
name: ai-figma-feature
description: Guides Figma-driven feature implementation using Figma MCP as UI source of truth. Use when building or validating screens against Figma designs.
---

# Figma Feature Skill

## Prerequisites
- Figma MCP must be configured and connected.
- If Figma MCP is not available, inform the user and fall back to manual
  design specs or screenshots.

## Before Starting
1. Read `.ai/project/DESIGN-SYSTEM.md` — know existing tokens and core widgets.
2. Read `.ai/project/CORE-CONFIGURATION.md` — know reusable components.
3. Confirm Figma MCP connectivity.

## Resource Routing — Figma → Codex → Figma MCP

### Roles
- **Antigravity** (orchestrator): owns implementation planning, architecture
  decisions, Core/design-system mapping, validation, and final approval.
- **Codex** (Figma MCP worker): uses the Figma MCP connection currently verified
  through Codex CLI. All Figma data retrieval is routed through Codex.

### Input Requirements
1. A Figma implementation task must include the Figma file URL. If it is
   missing, ask the user for it.
2. When a specific screen, frame, or component is targeted, require its exact
   node ID. If the target is missing or ambiguous, ask the user to identify it.
3. If the URL contains a `node-id` query parameter, extract and preserve it.
   Normalize hyphen-separated IDs to Figma's colon form (for example,
   `549-8455` becomes `549:8455`). Do not guess or substitute a node ID.

### Routing Protocol
```
User provides Figma file URL (+ exact node ID when available)
        │
        ▼
Antigravity extracts the original URL's node-id and normalizes its exact ID
        │
        ▼
Antigravity delegates to Codex with:
  • original Figma file URL
  • exact normalized node ID
  • list of inspection items (see checklist below)
        │
        ▼
Codex uses its verified Figma MCP connection (read-only by default) to retrieve
metadata and design context for the exact target node
        │
        ▼
Codex returns structured design context to Antigravity
        │
        ▼
Antigravity owns project mapping, implementation, validation, and final approval
```

### Required Figma Context
Before implementation, Codex returns the available target context in a
structured form, including:
- Hierarchy and component structure
- Dimensions and constraints
- Layout direction and alignment
- Padding, margins, and gaps
- Typography: family, weight, size, line height, and letter spacing
- Colors, opacity, borders, corner radii, and shadows
- Icons, images, illustrations, and other asset references
- Interactive states
- Responsive behavior and constraints
- Relevant variables and reusable components, when available

### Asset Handling
- Antigravity inspects the existing Flutter `assets/` structure first and
  identifies the assets required by the target design.
- Reuse matching project assets when possible. Before adding an asset, check for
  duplicates and avoid blind downloads.
- Download only assets that are required for the implementation. Do not
  download assets automatically or speculatively.
- Preserve suitable asset categories, such as icons, images, illustrations,
  fonts, and lotties, where applicable.
- Do not download fonts blindly; verify actual usage and need before adding one.

### Handoff and Validation
Keep work modular and progressive: Codex returns only the requested target's
structured context, and Antigravity remains responsible for project decisions
and implementation. The end-to-end handoff is:

`Figma → Codex/Figma MCP → structured design context → Antigravity → Flutter implementation → runtime validation → Figma comparison → fixes → final validation`

For UI fidelity, Antigravity implements from the extracted Figma data, runs the
Flutter app, and captures or inspects the runtime result. Compare it with Figma
for structure, dimensions, typography, spacing, colors, assets, RTL, interactive
states, and responsiveness. Fix discrepancies and repeat the runtime comparison
until validated, then perform final validation. Never claim “pixel-perfect”
fidelity without runtime-versus-Figma comparison evidence.

### Failure and Recovery
- Missing Figma URL: ask the user for the URL.
- Missing or ambiguous target node: ask the user for the exact target; do not
  guess a node ID.
- Figma access failure: report the actual MCP failure and do not invent design
  data.
- MCP unavailable: document that it is unavailable and use the existing manual
  design-spec or screenshot fallback. Clearly distinguish fallback information
  from inspected Figma context.
- Never claim successful Figma inspection without evidence from the MCP result.

### Safety
- Figma inspection is **read-only by default**. Never modify Figma unless the
  user explicitly authorizes it.
- Do not introduce architecture, state-management, provider, dependency, MCP, or
  external-service changes through this workflow. Keep implementation within
  the existing project architecture and master workflow.

## Figma Inspection Checklist
Extract from Figma before writing any code:

- [ ] Component hierarchy and structure
- [ ] Typography: font family, weight, size, line height, letter spacing
- [ ] Colors: fills, strokes, opacity
- [ ] Spacing: padding, margins, gaps
- [ ] Dimensions: width, height, constraints
- [ ] Alignment and layout direction
- [ ] Border radius
- [ ] Borders and strokes
- [ ] Shadows and elevation
- [ ] Gradients
- [ ] Icons and image assets
- [ ] Interactive states (default, hover, pressed, disabled, selected)
- [ ] Responsive behavior and breakpoints
- [ ] Relevant variables and reusable components, when available

## Implementation Flow
1. **Inspect Figma** — Extract all structured design data for the target screen/component.
2. **Map to Core** — Match Figma values to existing AppColors, AppTextStyles, core widgets.
3. **Identify gaps** — Note any design tokens or components not yet in Core.
4. **Plan** — Define file structure. Decide if Core needs extension (approval gate).
5. **Implement** — Build the UI using extracted values. Never guess values available in Figma.
6. **Run app** — Render the screen on device/emulator.
7. **Compare** — Visually compare rendered UI against Figma.
8. **Fix discrepancies** — Iterate until structure, spacing, typography, and colors match.
9. **Validate** — Run static analysis. Update checkpoint.

## UI Fidelity Priority
1. Structure / layout hierarchy
2. Dimensions (width, height)
3. Typography (font, size, weight, line height)
4. Spacing (padding, margins)
5. Colors
6. Icons and images
7. Borders and radius
8. Shadows and gradients
9. States and interactions
10. Responsiveness

## Rules
- Figma is the UI source of truth. Do not override Figma measurements with assumptions.
- Use `AppColors` and `AppTextStyles`. If Figma introduces a new token, propose adding
  it to the design system (with approval if it changes Core).
- Use real project assets from `assets/`. Do not invent placeholder replacements.
- Never claim "pixel perfect" without visual comparison evidence.
- If Figma MCP is unavailable, document this clearly and proceed with best-effort
  implementation using any available design specs.
