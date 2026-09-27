---
name: ai-checkpoint-recovery
description: Recovers and resumes interrupted or transferred development tasks using persistent .ai/state checkpoint files. Use when continuing a task after a new session, account switch, model/provider change, token exhaustion, agent handoff, crash, interruption, or when the user says continue or resume.
---

# AI Checkpoint & Recovery

## 1. Purpose

This skill defines the mandatory recovery protocol for interrupted, transferred, or resumed development tasks.

The purpose is to continue work from the exact known project state without unnecessarily restarting, rescanning, or repeating completed work.

The core principle is:

> The conversation may be temporary. The project state must not be.

---

## 2. When This Skill Applies

Use this skill when any of the following occurs:

- A previous AI session ended unexpectedly.
- Token/context limits were reached.
- The user switches accounts.
- The user switches models.
- The user switches AI providers.
- The user starts a new conversation for the same project.
- Another agent is taking over the task.
- Antigravity, Codex, OpenCode, Claude, or another agent is continuing previous work.
- The development environment crashed or was interrupted.
- The user says:
  - "continue"
  - "resume"
  - "continue from where we stopped"
  - "pick up where we left off"
  - "recover the task"
  - "use the checkpoint"
  - or equivalent wording.

---

## 3. Recovery Priority

When recovery is required, use this priority order:

1. `.ai/state/LAST-CHECKPOINT.md`
2. `.ai/state/CURRENT-TASK.md`
3. `.ai/state/CURRENT-PLAN.md`
4. `.ai/state/PROGRESS.md`
5. Current Git status and diff
6. Current project/code state
7. Relevant project documentation
8. Conversation history, if available

Persistent project state takes priority over assumptions from memory.

---

## 4. Do Not Restart Automatically

Never restart the entire task just because the previous conversation ended.

Do not:

- redo completed work,
- repeat completed analysis,
- rescan the entire project unnecessarily,
- recreate files that already exist,
- repeat already-completed implementation steps,
- discard existing changes,
- reset Git,
- revert code,
- or assume that unfinished means unstarted.

First determine the exact current state.

---

## 5. Initial Recovery

When activated:

1. Locate `.ai/state/`.
2. Read the available state files.
3. Identify the current task.
4. Identify the last completed action.
5. Identify the current unfinished action.
6. Identify the next intended action.
7. Check Git status.
8. Compare checkpoint information with the actual project state.
9. Resolve discrepancies.
10. Continue from the earliest genuinely incomplete step.

---

## 6. Required State Files

The preferred state structure is:

```text
.ai/
└── state/
    ├── CURRENT-TASK.md
    ├── CURRENT-PLAN.md
    ├── PROGRESS.md
    └── LAST-CHECKPOINT.md