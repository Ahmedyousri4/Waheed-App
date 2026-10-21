# Codex Figma Inspection — Fallback via REST API

## Status
BLOCKED — Figma MCP OAuth tokens are age-encrypted in Codex's secrets store
and cannot be extracted for manual REST API calls.

## Attempted Approaches
1. Codex exec with MCP tools — FAILED (mcp.figma.com times out at TCP level)
2. Codex exec with REST API — BLOCKED (OAuth tokens age-encrypted, not accessible)
3. Next: Browser visual inspection fallback

## Network Diagnostics Summary
- mcp.figma.com: DNS resolves, direct IP connects, but hostname TCP times out (SNI filtering)
- www.figma.com: REACHABLE (HTTP 200)
- api.figma.com: REACHABLE (HTTP 401 — needs auth)
- Figma design URL should be accessible if user is logged in via browser