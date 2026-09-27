# Architecture Policy — Waheed

## Active Profile: Minimal

## Decisions

1. **State management**: ValueNotifier — do not migrate without approval.
2. **Navigation**: Imperative Navigator — do not migrate without approval.
3. **Architecture**: Feature-based, no Clean Architecture layers.
4. **DI**: None — do not introduce without approval.
5. **Repository pattern**: Used only in checkout/payment. Do not force elsewhere.
6. **File size**: 400-line target. Extract only when it improves maintainability.
7. **Core changes**: Require awareness; global impact must be stated.

## Rationale
The project is small enough that simple patterns keep it readable and
maintainable. Heavier patterns would be over-engineering at this scale.
