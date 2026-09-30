---
name: ai-release-check
description: Validates release readiness for the Waheed Flutter project. Use before preparing a release build or publishing to a store.
---

# Release Check Skill

## Pre-Release Checklist

### Build
- [ ] `flutter analyze` — no errors
- [ ] `flutter test` — all tests pass
- [ ] `flutter build apk --release` or `flutter build appbundle` — builds successfully
- [ ] `flutter build ios --release` — builds successfully (if targeting iOS)

### Configuration
- [ ] Version and build number updated in `pubspec.yaml`
- [ ] `debugShowCheckedModeBanner: false` confirmed in `main.dart`
- [ ] No debug logging left in production code paths
- [ ] `pretty_dio_logger` disabled or removed for release

### Assets
- [ ] All referenced assets exist in `assets/`
- [ ] Fonts render correctly (Inter, Cairo)
- [ ] Icons and images load without errors

### API & Environment
- [ ] API endpoints point to production
- [ ] No hardcoded development URLs
- [ ] Authentication configured for production
- [ ] SignalR connection configured for production

### Security
- [ ] No API keys or secrets in source code
- [ ] `.gitignore` covers `.env`, `*.jks`, `*.keystore`, `key.properties`
- [ ] No sensitive data logged

### Platform-Specific
- [ ] Android: `minSdkVersion`, `targetSdkVersion` appropriate
- [ ] Android: signing configuration set (keystore, key.properties)
- [ ] Android: ProGuard/R8 rules if needed
- [ ] iOS: Bundle ID, signing team, provisioning profile configured
- [ ] iOS: Info.plist permissions declared (camera for image_picker, location for maps)

### UI Validation
- [ ] Critical flows tested: splash → home → product → cart → checkout
- [ ] RTL layout verified
- [ ] Localization strings correct

### Git
- [ ] Working tree clean
- [ ] All changes committed
- [ ] Release branch/tag created if using branching strategy

## Rules
- Do not claim release readiness without actual validation evidence.
- Each unchecked item must be reported with its status.
- Blocking issues must be clearly flagged.
- This skill does not perform fixes — it identifies issues for resolution.
