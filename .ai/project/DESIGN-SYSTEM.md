# Design System — Waheed

## Colors (AppColors)
| Token           | Hex       | Usage                    |
|-----------------|-----------|--------------------------|
| gold            | #C9A961   | Brand accent             |
| goldDark        | #473100   | Brand dark               |
| navy            | #314158   | Brand secondary          |
| black           | #111111   | Primary text, headings   |
| background      | #FAFAFA   | Page background          |
| surface         | #FFFFFF   | Cards, containers        |
| border          | #ECECEC   | Standard borders         |
| textPrimary     | #111111   | Main text                |
| textSecondary   | #8F8F8F   | Secondary text           |
| textMuted       | #A0A0A0   | Muted labels             |
| textSlate       | #94A3B8   | Slate labels             |
| error           | red       | Error states             |
| star            | #FFC107   | Rating stars             |

## Typography (AppTextStyles)
| Style         | Size | Weight   | Color         |
|---------------|------|----------|---------------|
| heading       | 22   | bold     | textPrimary   |
| titleLarge    | 17   | bold     | textPrimary   |
| titleMedium   | 16   | bold     | textPrimary   |
| titleSmall    | 14   | bold     | textPrimary   |
| bodyLarge     | 15   | w600     | textPrimary   |
| body          | 13   | normal   | textSecondary |
| bodySmall     | 12   | normal   | textSlate     |
| label         | 14   | w700     | textPrimary   |
| labelSmall    | 11   | normal   | textSlate     |
| stepLabel     | 12   | w500     | gold          |
| brand         | 13   | w900     | black         |
| navLabel      | 11   | w600     | textMuted     |
| navLabelActive| 11   | bold     | black         |

Font family: Inter (default), Cairo (Arabic body, in pubspec)

## Core Widgets
| Widget              | File                         | Purpose                          |
|---------------------|------------------------------|----------------------------------|
| AppImage            | core/widgets/app_image.dart  | SVG/PNG/Lottie/Network universal |
| AppBackButton       | core/widgets/app_back_button.dart | Circular back button        |
| CartBadgeButton     | core/widgets/cart_badge_button.dart | Cart icon with count badge |
| ProductCard         | core/widgets/product_card.dart | Single-source product card     |

## Reuse Rules
- Always use `AppColors` — never inline hex values.
- Always use `AppTextStyles` where applicable.
- Always use core widgets before creating new ones.
- If a new reusable pattern emerges, propose adding it to core.
