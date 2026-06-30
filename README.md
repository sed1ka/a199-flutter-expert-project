# Ditonton - Flutter Expert Project

[![Codemagic build status](https://api.codemagic.io/apps/6a44295d9c8a9ed31e7a1c0c/6a44295d9c8a9ed31e7a1c0b/status_badge.svg)](https://api.codemagic.io/apps/6a44295d9c8a9ed31e7a1c0c/6a44295d9c8a9ed31e7a1c0b/latest_build)

A comprehensive Flutter application for discovering movies and TV series, built with a modular architecture and clean code principles. This project is part of the "Menjadi Flutter Developer Expert" course from Dicoding.

## 🚀 Features

- **Movie Discovery**: Browse now playing, popular, and top-rated movies.
- **TV Series Discovery**: Browse on-the-air, popular, and top-rated TV series.
- **Detailed Information**: view synopsis, genres, runtime/seasons, and recommendations.
- **Search**: Find your favorite movies and TV series by title.
- **Watchlist**: Save movies and TV series to your personal watchlist for later.
- **Modular Architecture**: Clean separation of concerns using feature-based modules.
- **State Management**: Robust implementation using **Flutter BLoC**.
- **Unit & Widget Testing**: Comprehensive test coverage with Mockito.
- **Integration Testing**: End-to-end user journey tests.
- **CI/CD**: Automated testing and building using Codemagic.

## 🏗️ Project Structure

The project is organized into several local modules to promote scalability and maintainability:

- `modules/core`: Shared utilities, themes, constants, and network info.
- `modules/db`: Database helpers and local storage logic.
- `modules/about`: Simple about page.
- `modules/movie`: Movie-related data, domain, and presentation (BLoC).
- `modules/tv`: TV Series-related data, domain, and presentation (BLoC).
- `modules/watchlist`: Watchlist logic and persistence for both movies and TV series.

## 🧪 Testing

### Running Unit & Widget Tests
Tests are located within each module. You can run them all using the provided script:
```bash
chmod +x run_tests.sh
./run_tests.sh
```

### Running Integration Tests
Integration tests cover the main user journeys:
```bash
flutter test integration_test/app_test.dart
```

## 🛠️ CI/CD with Codemagic

This project uses Codemagic for continuous integration. Every push or pull request to the `final-project` branch triggers:
1. **Pub Get**: Fetching dependencies for all modules.
2. **Static Analysis**: Ensuring code quality with `flutter analyze`.
3. **Automated Testing**: Running all unit, widget, and integration tests.
4. **Build**: Generating the production release APK.

---

### How to get your Status Badge:
1. Go to your **Codemagic Dashboard**.
2. Select this project -> **Settings** -> **Notifications** -> **Status Badges**.
3. Copy the Markdown code and replace the badge section at the top of this file.
