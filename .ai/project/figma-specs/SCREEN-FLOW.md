# Screen Flow — Splash → Get Started → Login

## Required target flow

```text
Splash Screen ──after splash──▶ Get Started ──press “البدء الآن”──▶ Login
```

This flow is explicitly required by the user. The Get Started CTA label is visible in the
local reference and supplied notes, and the task defines its destination as Login. This is
the required behavior for later implementation; no app code was changed here.

## Current project behavior (verified source)

- `lib/main.dart` sets `SplashScreen` as `MaterialApp.home`.
- `lib/features/splash/splash_screen.dart` waits three seconds then calls
  `Navigator.pushReplacement` to `HomeScreen`.
- The project uses imperative `Navigator.push`, `Navigator.pop`, and
  `Navigator.pushReplacement`; it does not configure a named/declarative router.
- `.ai/project/UI-FLOWS.md` currently documents `Splash → Home`.

Therefore the current app does **not** yet implement the target flow. During a later
implementation task, the splash replacement destination is the integration point for
Get Started, and its CTA must open Login using the existing imperative navigation style.

## Unspecified transitions and behavior

- Login submission result, authentication service behavior, validation rules,
  forgot-password destination, account-creation destination, social sign-in behavior, and
  post-login destination are unknown.
- The screenshot shows controls that look actionable, and a visible eye-off icon plus a
  local open-eye SVG suggests a possible visibility toggle; these behaviors are not
  confirmed by a static image.
- No transition other than Splash → Get Started → Login is specified. Do not implement
  inferred behaviors without separate product requirements.
---

## Figma selection flow - root 472:6759

The auth flow above is a separate selection. Canvas order is not navigation order. The eight direct-child frames are listed in SELECTION-MASTER-INDEX.md. No prototype edges were exposed in returned metadata/context. Verified transitions: 0; user-confirmed transitions: 0; inferred relationships remain unverified and are not routes.

| Source node | Control/state | Candidate destination | Evidence | Trigger/back behavior |
|---|---|---|---|---|
| 1068:2903 | Delete account row | 1068:3293 or 1068:2733 | Inferred candidate only | Unknown |
| 1068:2733 | Confirmation actions | 1070:3983, 1070:4185, or dismiss | Inferred candidate only | Unknown |
| 1070:3983 | Success copy / CTA | 1070:4185 or other | Inferred candidate; title/copy differ | Unknown |
| 1068:3293 | Warning-sheet actions | Deletion state or dismiss | Inferred candidate only | Unknown |
| 1068:2903 | Terms row | 472:6621 | Inferred from matching labels | Unknown |
| 1068:2903 | Privacy row | 472:6644 | Inferred from matching labels | Unknown |
| 498:3926 | Guest terms/privacy rows | 472:6621 / 472:6644 | Inferred from matching labels | Unknown |
| 498:3926 | Sign-in/create-account CTA | Destination outside selection / unknown | Affordance only | Unknown |
| Any screen | Back arrow, cart, bottom navigation | Unknown | Unknown | Unknown |

No inferred candidate in this table is a verified route. Prototype inspection was blocked by the Starter-plan call limit reported on 2026-10-24.