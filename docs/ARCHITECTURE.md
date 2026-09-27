# Architecture — Waheed Hassan Men's Suits

## Overview

The application follows a **Feature-Based Architecture** with a shared `core/` layer.
Each feature owns its screens and widgets. Cross-cutting concerns (state managers,
reusable widgets, theming) live in `core/` and `app/`.

## Directory Structure

```
lib/
├── main.dart                          # Entry point
├── app/
│   └── theme/
│       ├── app_colors.dart            # Centralized color palette
│       └── app_text_styles.dart       # Reusable text style presets
│
├── core/
│   ├── managers/
│   │   ├── cart_manager.dart          # Cart state (ValueNotifier)
│   │   └── favorite_manager.dart      # Favorites state (ValueNotifier)
│   └── widgets/
│       ├── app_image.dart             # Universal SVG/PNG/Lottie/Network image
│       ├── app_back_button.dart       # Standard circular back button
│       ├── cart_badge_button.dart      # Cart icon with count badge
│       └── product_card.dart          # Single-source ProductCard with cart/fav
│
├── models/
│   └── product.dart                   # Typed Product data class
│
└── features/
    ├── splash/
    │   └── splash_screen.dart
    ├── home/
    │   ├── home_screen.dart           # Root screen + bottom nav
    │   └── widgets/
    │       ├── home_widgets.dart       # NotificationButton, SearchBar, Carousel
    │       └── home_sections.dart      # CategoriesSection, ProductsSection
    ├── categories/
    │   └── all_categories_screen.dart
    ├── products/
    │   └── latest_products_screen.dart
    ├── favorites/
    │   └── favorites_screen.dart
    ├── cart/
    │   ├── cart_screen.dart
    │   └── widgets/
    │       └── cart_item_card.dart
    ├── product_details/
    │   ├── product_details_screen.dart
    │   └── widgets/
    │       ├── product_sections.dart   # Hero image, gallery, info
    │       ├── product_extras.dart     # Features, colors, description
    │       └── purchase_widgets.dart   # Similar products, bottom bar
    └── suit_measurements/
        ├── suit_measurements_screen.dart
        └── widgets/
            ├── step_indicators.dart
            ├── step_header.dart
            ├── guide_card.dart
            ├── size_selector.dart
            ├── measurements_card.dart
            └── review_widgets.dart
```

## Layers

### `app/theme/`
Design tokens: colors and text styles. Every file in the project should
reference `AppColors` and `AppTextStyles` rather than inline hex codes.

### `core/`
Framework-level utilities shared across all features:
- **managers/** — Global state containers using `ValueNotifier` (cart, favorites).
- **widgets/** — Reusable UI components not tied to any single feature.

### `models/`
Typed data classes. Currently contains `Product` which replaces the
`Map<String, dynamic>` pattern used before refactoring.

### `features/`
One folder per user-facing feature. Each folder contains:
- A root screen file (e.g. `home_screen.dart`)
- An optional `widgets/` sub-folder for extracted child widgets

## State Management

| Concern   | Pattern          | Location                        |
|-----------|------------------|---------------------------------|
| Cart      | ValueNotifier    | `core/managers/cart_manager.dart`    |
| Favorites | ValueNotifier    | `core/managers/favorite_manager.dart`|
| UI state  | setState         | Individual StatefulWidgets      |

The app uses Flutter's built-in `ValueNotifier` + `ValueListenableBuilder`
for shared state. This is intentional — the app is small enough that
introducing a heavier pattern (BLoC, Riverpod) would be over-engineering.

## Dependency Rules

```
features/ ──→ core/
features/ ──→ models/
features/ ──→ app/theme/
core/     ──→ (Flutter SDK only)
models/   ──→ (Dart only, no Flutter imports)
```

Features may import other features for navigation (e.g. home → product_details).
Core never imports features.

## File Size Constraint

**Maximum 400 lines per source file.** This is enforced to keep files
scannable and maintainable. If a file grows past this limit, extract
child widgets or helper functions into the feature's `widgets/` folder.

## Fonts & Localization

- Primary font: **Inter** (Latin + numbers)
- Secondary font: **Cairo** (Arabic body text, defined in pubspec)
- Text direction: **RTL** (Arabic-first UI)
- Localization: Arabic-only via `flutter_localizations`
