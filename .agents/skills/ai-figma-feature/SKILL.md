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

If the user explicitly requests Flutter implementation, activate and follow the canonical Master Engineer Screen & Feature Implementation Workflow in `.agents/skills/ai-feature-development/SKILL.md` and the core engineering rules in `.agents/rules/00-ai-engineering-core.md`. Follow the existing Waheed feature-based architecture, Navigator conventions, shared widgets/tokens, strict 300-line limit per file, and state-management rules. Do not introduce architecture, dependencies, or broad Core changes without the project-required approval. Verify the rendered requested screen against Figma or existing specifications before claiming fidelity. Update a specification only for a genuine discovered discrepancy and record its resolution. The user’s explicit task scope takes precedence over generic workflow defaults.

## Multi-Screen Figma Extraction and Sequential Implementation

For a multi-screen selection, inspect the full selected node and relevant descendants. Do not treat one screenshot or the first frame as the complete selection. Record each screen's exact node ID and source link. Keep canvas order separate from prototype navigation order.

### Project recovery and references

Before extraction or implementation, read `.ai/state/LAST-CHECKPOINT.md`, `.agents/rules/00-ai-engineering-core.md`, and relevant existing skills: feature development, Core integration when shared Core is affected, testing/validation, and code review. Inspect existing `.ai/project/figma-specs/`, related project documentation, current assets, and `graphify-out/graph.json`. Reuse the graph and established workflows for structural context; do not rescan the repository without a concrete reason. Inspect the actual `AppImage` API, local routing, typography, theme, and asset conventions before mapping design elements.

Read these selection documents when present:

- `.ai/project/figma-specs/SELECTION-MASTER-INDEX.md`
- `.ai/project/figma-specs/SCREEN-FLOW.md`
- `.ai/project/figma-specs/DESIGN-TOKENS.md`
- `.ai/project/figma-specs/ASSET-INVENTORY.md`
- `.ai/project/figma-specs/COMPONENT-INVENTORY.md`
- `.ai/project/figma-specs/IMPLEMENTATION-READY-BRIEF.md`
- `.ai/project/figma-specs/EXTRACTION-COVERAGE-REPORT.md`

Consult each requested screen's individual specification before implementation. Keep screen-specific design data in those documents, not in this reusable skill.

### Multi-screen execution contract

Whenever the user requests implementation of an entire selection or group of documented screens:

1. Build a complete screen checklist from the master index before editing. Identify shared dependencies and reusable widgets before duplicating UI code.
2. Implement in a dependency-aware order, respecting prerequisite screens/components while preserving the verified user-facing navigation flow. Canvas order alone never establishes implementation or navigation order.
3. Follow `SCREEN-FLOW.md` for routes and interactions. Label every relationship **Verified Figma prototype**, **User-confirmed**, **Inferred**, or **Unknown**. Inferred or unknown behavior must never silently become a verified route; ask for clarification when it materially affects implementation.
4. Reuse verified local assets and existing Core widgets. Use `AppImage` for supported image/icon/vector rendering only after confirming the actual API supports that asset type and mode. Never fabricate missing assets, exact measurements, interactions, or destinations. Record unresolved details as blockers or explicit assumptions.
5. Implement and validate screens incrementally. A screen is complete only after its implementation and relevant validation are checked against its individual specification and Figma reference. Connect requested screens through documented routes/interactions; do not leave them as disconnected pages.
6. Do not claim the selection complete while requested screens, important interactions, required assets, or essential validations remain unfinished. Run formatting, analysis, and relevant tests per the existing project workflow and record actual results.
7. Preserve existing behavior and follow Master Engineer Workflow approval gates. Keep source files at or below 300 lines, extracting focused reusable files as needed. Do not add an unapproved state-management library, architectural redesign, dependency, or configuration change.
8. Update `.ai/state/LAST-CHECKPOINT.md` with completed screens, changed files, validation results, remaining screens, blockers, and the precise next action.

For extraction-only tasks, keep implementation code untouched. Maintain the inventory, per-screen specifications, token/component/asset inventories, flow map, handoff brief, and coverage report in `.ai/project/figma-specs/`, updating existing documents rather than duplicating them. Mark unavailable properties and assets explicitly and report partial readiness honestly.

## Mandatory Incremental Extraction and Archive Policy

At the start of every Figma task or resumed session, read `.ai/state/LAST-CHECKPOINT.md`, `.ai/project/figma-specs/extraction-archive/EXTRACTION-STATE.json`, `SCREEN-REGISTRY.json`, the relevant screen specifications, and `ASSET-REGISTRY.json` / `ASSET-INVENTORY.md`. Use the session log for history and resume instructions. Determine completion by each screen's category statuses and evidence, not by the existence of a summary.

Before requesting new Figma data:

1. Compare the target screen and requested data categories against the registry, node extraction record, and linked specification.
2. Reuse existing verified information without repeating calls. Re-extract a complete category only for a documented reason: source-change evidence, conflict, stale/invalid data, or a specifically requested revalidation.
3. Do not repeat broad root inspection when the inventory covers the root, unless there is evidence it changed or the inventory is incomplete. Never re-export a locally verified asset mapped to the same Figma node. Filename/dimensions alone do not establish an asset match.
4. Request only missing, partial, blocked, changed, or unverified data. A new Figma account does not prove file permission or quota availability. Re-authenticate only when new Figma access is required; if MCP access is blocked, continue with local records and do not retry a known quota failure.
5. After every successful extraction batch, immediately update the relevant screen specification, node record, asset registry/inventory, token/component/flow documentation, extraction state, and session log. Preserve earlier evidence and record conflicts before changing a current value.
6. Use only the statuses `not_started`, `partial`, `complete`, `blocked`, and `not_applicable`. A category may be `complete` only when its required evidence is captured in project files and reviewed. A brief summary alone never makes a screen complete. Unknown/inaccessible evidence remains explicit.
7. Before stopping, update the session log and state with the actual result, screens/categories completed, screenshot files actually saved (if any), assets actually exported and verified, blockers, current access status (or `not_checked`), and an exact resume point. Never claim raw responses, screenshots, or exported files are archived unless their project paths exist.

Archive location: `.ai/project/figma-specs/extraction-archive/`. Keep reusable procedure here in the skill and design facts in the screen specifications, registries, and inventories. `RAW-DATA/` is optional and may contain only actual captured responses; never recreate raw payloads from memory.
