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
