# Core Configuration — Waheed

## Core Status: Active (Selected Modules)

## Active Core Modules

### Managers (`core/managers/`)
- **CartManager** — Static ValueNotifier, add/remove/decrement/isInCart/itemCount
- **FavoriteManager** — Static ValueNotifier, toggle/isFavorite

### Widgets (`core/widgets/`)
- **AppImage** — Universal image widget (SVG, PNG, Lottie, Network)
- **AppBackButton** — Circular back button
- **CartBadgeButton** — Cart icon with live count badge
- **ProductCard** — Product display card with cart/favorite integration

### Theme (`app/theme/`)
- **AppColors** — Centralized color palette
- **AppTextStyles** — Reusable text style presets

## Notes
- Managers currently use `Map<String, dynamic>` internally despite typed
  `Product` model existing. Migration is incomplete.
- No extensions or utility files exist in core yet.
- Core never imports from features — this rule must be preserved.
