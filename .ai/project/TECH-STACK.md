# Tech Stack — Waheed

## Framework
- **Flutter** 3.29.0 (stable)
- **Dart** 3.7.0
- **DevTools** 2.42.2

## Dependencies (production)
| Package                | Version   | Purpose                        |
|------------------------|-----------|--------------------------------|
| flutter_localization   | ^0.3.3    | RTL/Arabic locale support      |
| flutter_svg            | ^2.2.1    | SVG asset rendering            |
| lottie                 | ^2.2.0    | Lottie animations              |
| google_maps_flutter    | ^2.14.0   | Map integration (checkout?)    |
| dio                    | ^5.9.2    | HTTP client                    |
| shared_preferences     | ^2.5.3    | Local key-value storage        |
| provider               | ^6.1.5+1  | Declared but not actively used |
| image_picker           | ^1.1.2    | Camera/gallery image selection  |
| pretty_dio_logger      | ^1.4.0    | Network request logging        |
| signalr_netcore        | ^1.4.4    | SignalR real-time messaging    |

## Dependencies (dev)
| Package        | Version | Purpose          |
|----------------|---------|------------------|
| flutter_test   | SDK     | Widget/unit test |
| flutter_lints  | ^5.0.0  | Static analysis  |

## Linting
- `package:flutter_lints/flutter.yaml` — default rules, no custom overrides active

## Notes
- `provider` is declared as a dependency but the app uses `ValueNotifier`
  for actual state management. Provider may be a leftover or planned future use.
