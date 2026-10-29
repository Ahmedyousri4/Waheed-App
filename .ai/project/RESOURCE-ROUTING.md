# AI Resource Routing — Waheed

## Active Resources

| Resource | Role | Status |
|----------|------|--------|
| **Antigravity** | Primary orchestrator | ✅ Active |
| **Codex** | Figma MCP worker, implementation delegate | ✅ Available (Figma MCP verified) |
| **OpenCode Desktop + BigPickle** | Cost-efficient implementation worker | ✅ Available (user-mediated) |

## Coordination Model

### Shared Workspace
All active resources operate on the same local workspace:
```
G:\projects\waheed  (branch: master)
```

### Coordination Mechanism
There is currently **no verified programmatic Antigravity → OpenCode bridge**.
OpenCode Desktop has a documented HTTP server/API, but it has not been
configured or connected for automated delegation.

Coordination uses **shared filesystem + checkpoint handoff**:
- Both Antigravity and OpenCode read/write the same project files.
- `.ai/state/LAST-CHECKPOINT.md` records current task state.
- `.ai/project/` documentation provides shared project context.
- `.agents/skills/` and `.agents/rules/` are available to both.
- Git state (branch, diff, status) is shared.

The **user is the router** for switching Antigravity/OpenCode implementation work.
For Figma analysis, a Figma URL or node URL sent directly to Codex automatically
activates `.agents/skills/ai-figma-feature/SKILL.md`; no separate detailed prompt or
Antigravity handoff is required. This does not authorize UI implementation.

### Verification Evidence
- OpenCode Desktop verified with BigPickle model in `G:\projects\waheed`.
- Canary result: `OPENCODE_BIGPICKLE_CANARY_OK`
- No project files were modified during verification.

## Evaluated but Unavailable

### AshnaAI
- **Status**: ❌ Not usable (Free plan — no external inference)
- **Intended use**: High-reasoning pool (GPT-6 Astra, Claude Fable) for complex bugs, architecture analysis, difficult refactors, Figma/UI fidelity analysis.
- **Required user action**: Upgrade to a paid plan that supports external inference.

### Chrome DevTools MCP
- **Status**: ❌ Not configured for this project
- **Intended use**: Runtime UI debugging, performance profiling, network inspection, accessibility audits.
- **Required user action**: Configure when runtime debugging is needed. Not required for system setup.

## Routing Policy

### Task → Resource Mapping
```
Simple/repetitive coding     → OpenCode + BigPickle (user-mediated)
Boilerplate / simple widgets → OpenCode + BigPickle (user-mediated)
Low-risk fixes               → OpenCode + BigPickle (user-mediated)
Routine refactoring          → OpenCode + BigPickle (user-mediated)
Simple test generation       → OpenCode + BigPickle (user-mediated)
Mechanical transformations   → OpenCode + BigPickle (user-mediated)

Normal Flutter feature       → Antigravity (primary)
                               Codex (Figma inspection if design-driven)

Figma URL/node analysis      → Codex automatically via ai-figma-feature
                               update existing project specifications
Figma implementation        → Antigravity (only when explicitly requested)
                               Codex provides Figma inspection as needed

Complex feature / bug        → Antigravity (high-reasoning)
                               AshnaAI (when available)

Architecture decisions       → Antigravity ONLY
Security-sensitive work      → Antigravity ONLY
Approval-gated changes       → Antigravity ONLY
Figma MCP access             → Codex ONLY

Independent code review      → AshnaAI or different model (when available)
                               Fallback: Antigravity self-review

Runtime UI debugging         → Chrome DevTools MCP (when configured)
                               Fallback: manual device/emulator inspection
```

### Tasks That Must NOT Be Routed to OpenCode + BigPickle
- Architecture decisions or major structural changes
- Complex debugging requiring deep reasoning
- Security-sensitive work (secrets, auth, data protection)
- Figma MCP inspection (Codex owns this)
- Approval-gated changes (Antigravity owns approval workflow)
- Core/shared component modifications with wide impact
- State management migration decisions

## Delegation / Handoff Protocol

### Antigravity → OpenCode (preparing a task)
1. Antigravity updates `.ai/state/LAST-CHECKPOINT.md` with:
   - Current task description
   - Specific subtask to delegate
   - Files to create or modify (explicit list)
   - Constraints (do not touch, approval gates)
   - Expected output
   - Validation criteria
2. User switches to OpenCode Desktop.
3. OpenCode reads `.ai/state/LAST-CHECKPOINT.md` and `.ai/project/` docs.
4. OpenCode executes the scoped subtask.
5. OpenCode updates the checkpoint with what was completed.

### OpenCode → Antigravity (returning work)
1. OpenCode updates `.ai/state/LAST-CHECKPOINT.md` with:
   - What was completed
   - Files created or modified
   - Any issues encountered
   - Status (complete / partial / blocked)
2. User switches to Antigravity.
3. Antigravity reads the checkpoint.
4. Antigravity reviews the diff, validates behavior, and continues.

### Safety Rules
- OpenCode must follow all `.agents/rules/` constraints.
- OpenCode must not bypass approval gates.
- If a delegated task becomes more complex than expected, OpenCode should
  stop and document the blocker in the checkpoint for Antigravity to handle.
- Neither tool should discard the other's uncommitted work.

## Current Operational Mode
Active resources:
- **Antigravity**: orchestration, planning, complex implementation, review, validation
- **Codex**: Figma MCP inspection (delegated by Antigravity)
- **OpenCode + BigPickle**: cost-efficient implementation (user-mediated delegation)

All project work can proceed with these resources. AshnaAI and Chrome DevTools
MCP are optional future additions, not blockers.

### Multi-screen Figma handoff
When a task targets multiple frames or a selected Figma section, invoke `.agents/skills/ai-figma-feature/SKILL.md`. Screen inventory, individual specifications, verified flow, assets, tokens, components, and handoff status belong in `.ai/project/figma-specs/`; recover the latest position from `.ai/state/LAST-CHECKPOINT.md` first.

For resumable Figma extraction, also read `.ai/project/figma-specs/extraction-archive/EXTRACTION-STATE.json`, `SCREEN-REGISTRY.json`, `ASSET-REGISTRY.json`, and `EXTRACTION-SESSION-LOG.md`. These are the durable category-level progress and resume records; consult the linked screen specs for evidence and details.
