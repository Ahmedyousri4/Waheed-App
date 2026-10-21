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
