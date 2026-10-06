---
name: ai-codebase-graph
description: >
  Builds and queries a structural codebase knowledge graph using Graphify for
  import/dependency analysis, class hierarchy mapping, architecture boundary
  verification, and scoped task planning. Use when a task benefits from
  understanding cross-file relationships or structural impact scope.
  Not required for simple tasks.
---

# Codebase Graph Skill

## Purpose

Provides a structural, queryable codebase knowledge graph that agents can
consult for import/dependency tracing, class hierarchy mapping, architecture
boundary verification, and file-level impact scoping — without reading the
entire codebase into context.

The graph is built and maintained using **Graphify** (`uv tool install graphifyy`).

## When to Use

Use the codebase graph when the task benefits from structural cross-file reasoning:

- **Architecture analysis** — import violations, coupling, class hierarchy, boundaries
- **Structural impact analysis** — "what files import or reference this component?"
- **Refactoring** — "what imports this class? What inherits from it?"
- **Feature development** — "what existing components could I reuse?"
- **Bug fixing** — "what files reference this module? Could the bug affect them?"
- **Code review** — "are all files that import the changed class updated?"
- **Task scoping** — generating a precise file list for delegated subtasks
- **Project bootstrap** — understanding an unfamiliar codebase quickly

## When NOT to Use

Do not force the graph into every task. Skip it when:

- The task touches 1-2 files with obvious dependencies
- The developer already knows the codebase structure
- The project is trivially small and fits in a single context read
- A simple `grep` or IDE search suffices

## Prerequisites

- **Python 3.10+** — required to run Graphify
- **Graphify CLI** — install via `uv tool install graphifyy` (recommended) or `pip install graphifyy`
- No external API keys required for code-only analysis (`--code-only` flag)
- Community naming and document analysis (optional) require an LLM provider

## Verified Capabilities (Empirical — Graphify 0.9.77)

The following were **verified by empirical extraction** on a real project:

| Capability | Verified | Relation Type |
|------------|----------|---------------|
| File detection and processing | ✅ | — |
| Method/function extraction with line locations | ✅ | `defines` |
| Field/property extraction | ✅ | `defines` |
| Import graph (package + relative) | ✅ | `imports` |
| Class hierarchy (extends) | ✅ | `inherits` |
| Interface implementation | ✅ | `implements` |
| Mixin usage | ✅ | `mixes_in` |
| Type references across files | ✅ | `references` |
| Navigation route detection | ✅ | `navigates` |
| Source location for every symbol | ✅ | — |
| Community/cluster analysis | ✅ | — |
| Incremental builds (SHA256 cache) | ✅ | — |
| Fully local, no API key (`--code-only`) | ✅ | — |

## Known Limitations

| Limitation | Impact |
|------------|--------|
| **No function-level call graph** | `calls` edges are not produced for all languages (verified missing for Dart). Do NOT use the graph for call-chain tracing. |
| **No `_callable` metadata** | Nodes lack callable/class type flags for some languages. |
| **Cross-file links can be sparse** | Type references exist but may not capture all actual dependencies. Supplement with `grep` for critical analysis. |
| **No dead-code detection** | Requires call graph, which is not available. |
| **GRAPH_REPORT.md requires LLM** | Community naming needs an LLM backend. `--code-only` produces `graph.json` but no human-readable report. |

> **Rule:** Do NOT claim or imply that the graph provides function-level
> call-chain tracing. Use it for **structural** analysis only: imports,
> class hierarchy, type references, architecture boundaries.

## Graph Lifecycle

### 1. Detect Project

Before building a graph, detect the project characteristics:

```
1. Identify source directories (e.g., lib/, src/, app/)
2. Detect primary languages from file extensions and config files
3. Check for existing graph: <project>/.graphify-out/graph.json
4. Determine if graph exists and is current, or needs (re)building
```

Do NOT assume any specific language or framework.

### 2. Build Graph

```bash
# Code-only build (recommended default — no API key needed)
graphify extract <project-path> --code-only

# Build specific directory only
graphify extract <project-path>/lib --code-only
graphify extract <project-path>/src --code-only
```

**Output directory:** `<project>/graphify-out/`

| File | Purpose | Requires LLM? |
|------|---------|---------------|
| `graph.json` | Machine-readable knowledge graph | No |
| `manifest.json` | Incremental build manifest | No |
| `.graphify_analysis.json` | Analysis metadata | No |
| `cache/ast/` | Per-file AST cache | No |
| `GRAPH_REPORT.md` | Human-readable summary | **Yes** (community naming) |
| `graph.html` | Interactive visualization | **Yes** |

### 3. Incremental Updates

Graphify uses SHA256 caching and only re-processes changed files.

```bash
# Re-run after code changes — only changed files are re-parsed
graphify extract <project-path> --code-only
```

**When to rebuild:**
- After implementing a feature or fix (if graph will be used for review)
- After a significant refactor
- Before architecture analysis or health checks
- NOT after every single edit — only when the graph will be queried

### 4. Querying the Graph

If Graphify MCP server is available, use MCP tools:
- `query_graph` — find relationships, dependencies, patterns
- `get_node` — inspect a specific component's connections
- `get_neighbors` — find direct dependents/dependencies
- `shortest_path` — trace connection between two components

If MCP is not configured, read `GRAPH_REPORT.md` for a static summary or
parse `graph.json` directly.

### 5. Graph Data Management

- The `graphify-out/` directory should be added to `.gitignore`
- Graph data is derived and can always be regenerated
- Do not commit graph output files to version control
- Do not treat graph data as more authoritative than actual source code

## Integration with Other Skills

This skill is a **support layer** for other workflow skills. It does not
replace them. Each consuming skill decides whether to consult the graph.

### ai-architecture-analysis
- Use graph `imports` links to detect dependency violations
- Use graph `inherits` links to map class hierarchy
- Use graph to verify architecture boundaries (e.g., core ↛ features)

### ai-feature-development
- Use graph `imports`/`references` to identify reusable components
- Use graph to determine which files a new feature will interact with
- Use graph to generate a pre-implementation scope/file list

### ai-bug-fix
- Use graph `imports`/`references` to find files that reference the buggy component
- Use graph `inherits` to check if subclasses are affected
- Note: function-level call tracing is NOT available — supplement with grep

### ai-refactor
- Use graph `imports`/`references` to identify files that import or reference the component
- Use graph `inherits`/`implements` to find subclasses before modifying a base class
- Note: function-level caller identification is NOT available — supplement with grep

### ai-code-review
- Use graph to verify that all files importing a changed component were considered
- Use graph to check that new code follows existing import/dependency patterns
- Use graph to confirm no unintended new coupling was introduced

### ai-core-integration
- Use graph `imports` to find all files importing a Core component
- Use graph to verify that Core does not import from features
- Use graph `references` to check if a pattern is referenced by 2+ features

### ai-project-health-check
- Use graph to identify highly connected nodes and coupling hotspots
- Use graph `imports` to verify dependency rule compliance
- Note: dead-code detection is NOT supported by the graph alone

### ai-project-initialization
- Use graph to quickly understand an unfamiliar codebase structure
- Use graph `inherits`/`imports` to detect architecture patterns
- Use graph communities to identify logical module groupings

### Task scoping (BigPickle / worker delegation)
- Use graph `imports`/`references` to generate file lists for delegated subtasks
- Use graph to identify structural "blast radius" of a proposed change
- Include graph-derived scope in checkpoint handoff

## MCP Configuration (Optional)

If the project benefits from live graph queries, configure the Graphify
MCP server. This is additive — it does not replace any existing MCP servers.

### Antigravity (Gemini)
Add to `~/.gemini/config/mcp_config.json` (alongside existing servers):
```json
{
  "mcpServers": {
    "graphify": {
      "command": "python",
      "args": ["-m", "graphifyy.mcp"]
    }
  }
}
```

### OpenCode
Add to the project's OpenCode config under the `mcp` key:
```json
{
  "mcp": {
    "graphify": {
      "type": "local",
      "command": "python",
      "args": ["-m", "graphifyy.mcp"]
    }
  }
}
```

MCP configuration is optional. The graph can also be used by reading
`GRAPH_REPORT.md` and `graph.json` directly.

## Rules

1. The graph is a **tool**, not a mandate. Use it when it adds value.
2. Never treat graph data as more authoritative than actual source code.
3. Always verify graph-derived conclusions against real files before acting.
4. Do not commit `graphify-out/` to version control.
5. Do not require an external API key for basic code analysis.
6. Do not assume any specific language — detect from the project.
7. Prefer incremental updates over full rebuilds.
8. Do not modify source code to accommodate the graph tool.
9. This skill is project-agnostic. No hardcoded paths or language assumptions.
10. Do NOT claim or use the graph for function-level call-chain tracing.
11. For call-graph or dead-code analysis, use grep/IDE search instead.
