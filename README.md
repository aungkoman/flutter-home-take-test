# J' Donuts

A Flutter take-home project for browsing donuts, choosing a shop, managing a cart, and exploring membership rewards. The main demo works offline using bundled assets and a local database.

## Flutter and Dart versions

| Tool | Version |
| --- | --- |
| Flutter | 3.47.9, stable |
| Dart | 3.13.7 |
| App | 1.0.0+1 |

The Dart constraint in `pubspec.yaml` is `^3.13.7`. The versions above match the SDK used for development. Android and iOS are the configured platforms; the iOS deployment target is 15.0.


## Demo

ios demo screen recording

https://drive.google.com/file/d/1ye7W2iLdlWUjQiNk9XS-Su44N_sHfjub/view?usp=sharing

## How to run

Install Flutter and the platform tools: Android Studio/Android SDK for Android, or Xcode on macOS for iOS. Start an emulator/simulator or connect a device, then run from the repository root:

```sh
flutter --version
flutter doctor
flutter pub get
flutter devices
flutter run -d <device-id>
```

No API keys, backend service, or environment file is required. Package downloads and the first platform build need internet access. Once installed, the seeded demo can be used offline.

Generated Drift and JSON files are committed. After changing database tables or annotated models, regenerate them:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Build Android or an unsigned iOS app:

```sh
flutter build apk --release
# macOS with Xcode required:
flutter build ios --release --no-codesign
```

The APK is written to `build/app/outputs/flutter-apk/app-release.apk`. Installing on a physical iPhone requires signing in Xcode. App names, launcher icons, and the native iOS splash screen require a rebuild; hot reload does not update them.

## Demo accounts and fake OTP

Use **`123456`** as the six-digit OTP for every demo account. Verification is local; no SMS is sent. The resend action restarts a five-minute countdown without sending a message.

| Phone number | Member tier | Current points |
| --- | --- | ---: |
| +959 12345678 | Silver | 100 |
| +959 12345679 | Gold | 650 |
| +959 12345670 | Platinum | 1,200 |

Local numbers, `+95` numbers, and numbers containing spaces or dashes are normalized before lookup. Existing members can log in; new users use the registration entry point, verify the fake OTP, and complete their profile.

A failed OTP attempt shakes and clears all six inputs, then focuses the first box. Phone validation messages appear below the input field.

## Architecture

The project follows a feature-first Clean Architecture structure:

```text
Screen / widget
  -> Riverpod notifier
  -> Domain use case
  -> Repository interface
  -> Repository implementation
  -> Local data source
  -> Drift / SQLite or secure storage
```

- **Presentation:** screens, reusable widgets, and Riverpod providers.
- **Domain:** entities, validators, use cases, and repository contracts.
- **Data:** repository implementations, data sources, models, database tables, and seeders.
- **Shared code:** theme, motion timings, price formatting, failures, and the base use-case contract.

`get_it` wires repositories and use cases in `lib/injection_container.dart`. `lib/main.dart` injects them into the root `ProviderScope`. Use cases return `Either<Failure, T>` through `dartz`; presentation providers translate those results into loading, data, or error states.

`go_router` handles navigation and session redirects. A stateful shell preserves the Home, Rewards, Order, Wallet, and Settings tabs. The shared Drift database currently lives under the auth data folder and also includes product, rewards, and cart tables.

## Folder map

```text
lib/
  main.dart                       # Startup and provider overrides
  app_router.dart                 # Routes, session guards, tab shell
  injection_container.dart        # Dependency registration
  core/
    error/                        # Failures and exceptions
    motion/                       # Shared animation timings
    theme/                        # Theme, colors, spacing, radii
    usecase/                      # Base use-case contract
    utils/                        # Shared MMK price formatter
  features/
    auth/                         # Phone, OTP, registration, session, database
      data/
      domain/
      presentation/
    product/                      # Catalog, collections, products, shop details
      data/
      domain/
      presentation/
    cart/                         # Cart items and selected shop
      data/
      domain/
      presentation/
    rewards/                      # Membership, rewards, earn offers, gifts
      data/
      domain/
      presentation/
    home/presentation/            # Home sections, banners, header, tab shell
    order/                        # Order/map demo UI and domain scaffolding
    wallet/presentation/          # Wallet demo UI
    settings/presentation/        # Account/settings and logout
assets/
  images/                         # Bundled product and brand artwork
  seeds/                          # Auth, product/shop, and reward JSON
android/                          # Android app configuration and icons
ios/                              # iOS app, icons, native launch storyboard
test/                             # Unit, database, and widget tests
```

## State-management choice

The app uses **Riverpod 3** with `AsyncNotifierProvider` for asynchronous feature state and a stream provider for internet status. Providers expose explicit loading, success, and error states, support refresh/invalidation, and can be overridden in tests without a backend.

Session, catalog, product details, cart, and selected shop state are shared through providers. Small UI-only state, such as quantity controls, OTP digit controllers, animation controllers, and carousel position, stays inside widgets. `get_it` supplies dependencies; Riverpod owns reactive UI state.

## Offline strategy

- Drift stores users, membership tiers, products, categories, banners, shops, rewards, earn progress, cart items, and the selected shop in local SQLite (`hometake`).
- Bundled JSON seeds the database on first launch. Versioned migrations update existing installations; current schema version is **17**.
- Product and brand images are bundled, so browsing does not depend on image downloads.
- Cart data is scoped by user and shop. The selected shop is persisted locally.
- `flutter_secure_storage` stores the authenticated user ID. Startup restores that account from SQLite; logout clears the session without deleting the catalog.
- Pull-to-refresh reloads local data. There is no remote API, queued upload, or synchronization/conflict-resolution layer.
- Home shows an Online/Offline indicator using `internet_connection_checker_plus`. Its external reachability checks are informational and do not block local features.

Product prices use **MMK** throughout Home, collections, product details, catalog, and cart totals. Five earn offers show 0%, 25%, 50%, 75%, and 100% progress for each presentation account. The completed offer opens a demo points alert; it does not update points. The seeded amounts are demo values, with no exchange-rate conversion. A fixed random subset of 38 of the 154 seeded products is marked `isNew`, with a NEW badge on product details.

## Animations built

| Area | Behavior |
| --- | --- |
| Bottom navigation | Animated selection background, indicator position, and tab styling |
| Home/catalog | Staggered fade-and-slide entrances and animated loading skeletons |
| Banners | Auto-advancing page carousel and animated pagination indicators |
| Product navigation | Hero transitions for product images/names and collection artwork/titles, with route fades |
| Product details | Animated quantity changes |
| Rewards | Animated points ring, tier progress, challenge artwork, tab transitions, and staggered card entrances |
| Earn action | Press feedback and an attention animation when eligible |
| OTP failure | A short horizontal shake, input reset, and focus restoration |

Shared motion timings live in `lib/core/motion/app_motion.dart`. Reduced-motion handling is implemented for shared motion helpers, loading/entrance effects, rewards, and the OTP shake; it is not yet consistent across every transition. The native iOS launch screen is static, showing the logo on a soft pink background before Flutter renders.

## Tests and checks

```sh
flutter test
flutter analyze
```

Tests cover phone normalization and validation, registration, session restoration and logout, cart persistence/scoping, shop navigation, MMK formatting, new-product flags, connectivity indicator states, OTP failure behavior, theme, and selected animations.

Some existing analyzer findings remain outside the recently updated files, including unused imports, dependency declarations, and recursive getter warnings in rewards tables. Run the commands above against your checkout to see the current results; full-project analysis is not claimed to be clean.

## Known gaps

- Authentication and OTP are simulated locally. There are no production credentials, SMS delivery, OTP expiry enforcement, or server-side authentication.
- Checkout, payment, real order placement/history, and live wallet transactions are not implemented. The cart shows a checkout-unavailable message.
- Some Settings actions, profile editing, reward claims, and gift redemption show informational sheets rather than completing transactions.
- “Nearest shops” shows four random seeded shops for presentation. It does not request GPS access or calculate distance. Shop details show stored addresses/coordinates; the Order map is a placeholder.
- There is no backend synchronization, remote catalog refresh, or cross-device data sharing.
- The selected shop is stored at app level, while cart items are scoped by user and shop.
- Accessibility, reduced motion, and layouts across all device sizes need a broader manual review. Tests do not replace a full end-to-end device QA pass.
- Existing low-resolution logo artwork is reused for launcher and splash assets; higher-resolution source artwork would improve large-scale rendering.

## Time spent

Approximately **14 hours** in total, covering requirements, data modeling, architecture, local persistence, UI implementation, animations, testing, and presentation polish.
