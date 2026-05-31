# CryptoTracker

CryptoTracker is a Flutter cryptocurrency tracking application built for a technical assignment. The app focuses on production-style structure, readable code, offline resilience, and scalable feature organization.

## Features

- Global market overview
- Trending coins section
- Paginated cryptocurrency list
- Infinite scroll pagination
- Search coins
- Coin detail screen with live chart ranges
- Favorite and unfavorite coins with local persistence
- Pull to refresh
- Loading, error, and empty states
- Offline cache for market data and coin detail data
- Light and dark theme with system-theme support
- Language switching between English and Thai
- Currency switching
- GitHub Actions CI

## Architecture

The project uses **Clean Architecture + MVVM + Riverpod**.

### Layering

- `presentation/`
  - views
  - viewmodels
  - providers
  - UI state
- `domain/`
  - entities
  - repository contracts
  - use cases
- `data/`
  - remote/local data sources
  - DTO models
  - mappers
  - repository implementations

### Key architecture decisions

- **Riverpod** is used for dependency injection and state management.
- **MVVM** keeps UI logic inside viewmodels and business rules inside use cases.
- **Repositories** orchestrate remote API calls, local Hive cache, and offline fallback behavior.
- **Single-shell bottom navigation** keeps one shared scaffold and swaps tab content instead of pushing a new page for each tab.
- **Hive** is used for lightweight local persistence for settings, favorites, and cached API payloads.

## Project Structure

```text
lib/
  core/
  features/
    app_shell/
    market/
    coin_detail/
    favorites/
    settings/
  shared/
  l10n/
```

## Tech Stack

- Flutter
- Riverpod
- Dio
- Retrofit
- Hive
- GoRouter
- Freezed
- Easy Localization
- Cached Network Image
- Connectivity Plus
- Internet Connection Checker
- Mocktail

## Getting Started

### Prerequisites

- Flutter SDK 3.11+
- Dart SDK compatible with the Flutter version in `pubspec.yaml`

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

## Code Generation

Generated files are already included, but if you update Retrofit or Freezed models, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Localization

- Supported languages:
  - English
  - Thai
- Translation files:
  - `assets/translations/en.json`
  - `assets/translations/th.json`

All user-facing app strings should come from localization keys.

## Theming

- Light theme
- Dark theme
- System theme

Theme selection is persisted locally.

## Offline Support

When the device is offline:

- Market data loads from cached Hive data when available
- Coin detail data loads from cached Hive data when available
- Favorites remain available because they are stored locally

If no cache exists, the app shows a translated error state.

## Analysis and Tests

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Current automated coverage includes:

- use case behavior
- repository offline/cache behavior
- viewmodel state transitions

## CI

GitHub Actions is configured in:

```text
.github/workflows/flutter_ci.yml
```

The pipeline runs:

- `flutter pub get`
- `flutter analyze`
- `flutter test`

## API

Data is fetched from the CoinGecko public API:

- `GET /coins/markets`
- `GET /global`
- `GET /search/trending`
- `GET /coins/{id}`
- `GET /coins/{id}/market_chart`

## Assignment Notes

This project is structured to be easy to extend with more tabs, richer charting, stronger test coverage, and additional cached features without breaking the current architecture boundaries.
