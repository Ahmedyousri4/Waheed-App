---
name: ai-figma-feature
description: Automatically inspect and document Figma URLs, nodes, screens, frames, components, and designs with the configured Figma MCP. Also use when implementing or validating a Figma design, only when implementation is explicitly requested.
---

# Figma Analysis and Specification Workflow

## Automatic trigger and default mode

Activate this skill whenever the user provides a Figma URL (including a node URL), or asks to analyze, inspect, document, implement, or validate a Figma screen, frame, component, or design. A Figma URL alone is sufficient to start analysis and update the relevant existing specifications; do not ask the user to repeat this workflow in a detailed prompt.

**Default work is read-only design inspection plus project specification maintenance.** A Figma link does not authorize Flutter implementation, navigation changes, asset downloads, dependency/configuration edits, or edits to Figma. Implement only when the user explicitly asks for implementation or approves a separate implementation plan.

## Intake and project context

1. Extract the file key and exact node ID from the URL. Normalize a query such as node-id=549-8382 to 549:8382. For branch links, use the branch file key indicated by the URL. Preserve the original URL and node ID in the specification.
2. If the URL has no node ID, use the Figma metadata tool to list pages/top-level frames and identify a target only when the user’s wording and available project context make it unambiguous. Never guess a node ID. Ask one concise question only when the target remains essential and ambiguous.
3. Read the relevant existing screen specification first, then only the relevant shared files in .ai/project/figma-specs/: SCREEN-01-GET-STARTED.md, SCREEN-02-LOGIN.md, DESIGN-TOKENS.md, ASSET-INVENTORY.md, SCREEN-FLOW.md, and IMPLEMENTATION-READY-BRIEF.md. Check existing user-approved decisions and discrepancies before changing them.
4. For a new target or when project mapping is needed, inspect focused project memory: .ai/project/DESIGN-SYSTEM.md, .ai/project/CORE-CONFIGURATION.md, .ai/project/UI-FLOWS.md, .ai/project/RESOURCE-ROUTING.md, pubspec.yaml, and only the relevant source/asset directories. Do not repeatedly scan the repository.
5. Identify the target’s relationship to documented screens from file/page/frame hierarchy and the existing flow. If that relationship is not exposed, record it as unresolved instead of inferring it.

## Figma MCP inspection sequence

Use the configured official Figma MCP as the design source of truth. Inspect available tool schemas rather than assuming every server exposes the same operations.

Before calling a Figma tool, follow any prerequisite skills declared by that tool's
description. For this configured Figma MCP, load its figma-design-to-code guidance before
calling get_design_context, and follow its screenshot and logging requirements. Read-only
inspection does not require or authorize Figma write tools.

1. Read metadata for the exact target node to establish its name, type, bounds, and available descendant structure.
2. Request design context for the target and its screenshot when supported. If context does not include a screenshot and one is useful, request it with the screenshot tool.
3. Inspect relevant descendants—nested frames, groups, components, instances, text nodes, and visible asset layers. Use returned node IDs to request focused child contexts when the root result omits properties needed for the specification. Batch independent child requests where supported; do not re-fetch the whole file.
4. Inspect available variables, styles, component definitions, variants, and prototype/interaction data using the MCP tools that exist in this session. Record when a data category is unavailable or absent from the returned result; do not imply it was inspected.
5. Compare structured node properties with screenshots. Structured properties take precedence for exact values. Use screenshots as visual evidence and label screenshot-derived measurements as estimates.

### Extraction checklist

For every exposed target and relevant descendant, record the applicable properties:

- **Identity and hierarchy:** file URL/key, node ID, layer/frame name and type, parent/child relationships, component/instance/source relationships, variants and variant properties.
- **Frame and layout:** bounds, positions, dimensions, constraints, layout direction, alignment, justification, Auto Layout, gap, padding, wrap, sizing modes (fixed/fill/hug or equivalent), clipping, scrolling, fixed positioning, and responsive constraints.
- **Appearance:** fills and exact HEX/RGBA where available; opacity; gradients/stops; strokes/borders; radii; shadows, blur, and effects.
- **Text:** exact content including script, punctuation, tashkeel, and line breaks; family, style/weight, size, line height, tracking, paragraph spacing, alignment, decoration, fill/opacity, truncation, and exposed wrapping/overflow properties.
- **Assets:** image fills and crop/position, raster/vector identity, icon/logo/illustration references, export settings/scale/format, component-provided visuals, and whether a matching local asset exists.
- **Behavior:** prototype destination, trigger, overlay, state/variant, and transitions when exposed. Separate observed interactions from business logic that cannot be inferred from a design.

Capture only exposed values. A missing field is Not exposed or Unknown, not a default value.

## Asset and project safety

1. Inspect existing local assets before recommending an export. Compare content and dimensions where needed; filenames alone do not establish identity.
2. Update ASSET-INVENTORY.md with source node/layer, local path (or missing status), actual format/dimensions when verified, export details when exposed, match confidence, and recommended destination only when relevant.
3. Do not download, rename, move, overwrite, or create assets merely because a Figma URL was provided. Asset export is a filesystem modification; do it only when explicitly requested. Never replace an existing project asset without explicit authorization.
4. Do not edit Flutter source, navigation, pubspec.yaml, dependencies, app behavior, or Figma content during analysis/specification work.

## Evidence labels and discrepancy handling

Use explicit provenance labels throughout specifications:

- **Verified Figma:** exact value directly exposed by MCP for the cited node/property.
- **User-confirmed:** value or decision explicitly supplied/approved by the user.
- **Screenshot estimate:** visual measurement or observation from a rendered image, not an exact Figma property.
- **Inferred / provisional:** interpretation that is plausible but not directly established.
- **Unknown / not exposed:** unavailable from MCP, screenshot, local files, and user notes.

Preserve approved wording and decisions. If new Figma data conflicts with a user-approved value or an existing specification, record both sources and the discrepancy. Do not silently overwrite the approved decision; ask only if resolving the conflict is essential to the requested outcome.

## Maintaining project specifications

Use .ai/project/figma-specs/ and update existing documents; do not create duplicates:

- SCREEN-01-GET-STARTED.md
- SCREEN-02-LOGIN.md
- ASSET-INVENTORY.md
- DESIGN-TOKENS.md
- SCREEN-FLOW.md
- IMPLEMENTATION-READY-BRIEF.md

Update only files relevant to the target, plus shared token, asset, flow, or brief documents when the new facts affect them. A screen specification should preserve the original source URL, exact node/frame identity, hierarchy, source provenance, and a top-to-bottom implementation-ready description. Record supported values, estimates, assumptions, unresolved items, asset mappings, and behavior separately. Keep shared tokens internally consistent without copying one screen’s content into another screen’s specification.

## Limits, failures, and recovery

- Respect Figma permissions, quotas, and server limits. If MCP returns access denied, rate limit, quota exhaustion, timeout, or another error, report the actual message/category and stop repeated retries. Do not call a failed request again merely to see if it works.
- Continue only with local specifications, available screenshots/assets, and user-provided evidence. Label all such fallback facts by source; do not claim Figma inspection succeeded.
- If a screenshot or property cannot be retrieved, document exactly what is missing. Do not reconstruct a design from its URL, name, or unrelated screens.
- Avoid redundant calls. Prefer one focused metadata/context/screenshot pass and targeted descendant/property calls only for real gaps.

## Validation and response

Before finishing, make one focused consistency pass against the MCP results and project documentation. Check node IDs, frame names, text exactness, dimensions, typography, colors, spacing, layer hierarchy, asset references, source labels, and unresolved conflicts. Do not claim values were extracted if absent from tool responses.

Report the target node, sources/tools actually used, properties documented, asset status, exact files created or updated, unresolved properties/access limitations, and whether any implementation/configuration occurred. State clearly that no visual implementation comparison has been made unless one actually was.

## Explicit implementation requests

If the user explicitly requests Flutter implementation, first read the relevant project specifications and follow the existing Waheed feature-based architecture, Navigator conventions, shared widgets/tokens, and state-management rules. Do not introduce architecture, dependencies, or broad Core changes without the project-required approval. Verify the rendered requested screen against Figma before claiming fidelity. Update a specification only for a genuine discovered discrepancy and record its resolution. The user’s explicit task scope takes precedence over generic workflow defaults.
