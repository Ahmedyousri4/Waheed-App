# Architecture — Waheed

## Profile: Minimal

The project uses a simple **Feature-Based Architecture** appropriate for its
current size (~56 files, ~269 KB). No Clean Architecture layers, no DI, no
repository pattern beyond a single payment repository.

## Structure
```
lib/
├── main.dart                  # Entry point (WahheedyApp)
├── app/
│   └── theme/
│       ├── app_colors.dart    # Centralized color palette
│       └── app_text_styles.dart
├── core/
│   ├── managers/
│   │   ├── cart_manager.dart       # ValueNotifier<List<Map>>
│   │   └── favorite_manager.dart   # ValueNotifier<List<Map>>
│   └── widgets/
│       ├── app_image.dart
│       ├── app_back_button.dart
│       ├── cart_badge_button.dart
│       └── product_card.dart
├── models/
│   └── product.dart
└── features/
    ├── splash/
    ├── home/
    ├── categories/
    ├── products/
    ├── favorites/
    ├── cart/
    ├── product_details/
    ├── checkout/           # Largest feature (address, payment, review)
    └── suit_measurements/
```

## State Management
- **ValueNotifier** + `ValueListenableBuilder` for shared state (cart, favorites)
- **setState** for local UI state
- `provider` package is declared but not actively used for state

## Navigation
- Imperative `Navigator.push` / `Navigator.pop`
- No declarative routing (go_router, auto_route, etc.)

## API Layer
- **Dio** for HTTP
- **pretty_dio_logger** for debug logging
- **signalr_netcore** for real-time
- Single `payment_repository.dart` in checkout feature

## Dependency Rules
```
features/ → core/, models/, app/theme/
core/     → Flutter SDK only
models/   → Dart only
```
Features may import other features for navigation.

## File Size Policy
400-line maximum target per file.

## Known Oversized Files
| File | Lines | Status |
|------|-------|--------|
| checkout/order_review_screen.dart | 719 | Exceeds target |
| suit_measurements/suit_measurements_screen.dart | 516 | Exceeds target |
