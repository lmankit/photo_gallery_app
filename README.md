# Photo Gallery App

A Flutter mobile app for browsing and searching stock photos with pagination and offline support.

## Features

- Browse photos (sorted by date, newest first)
- Search photos by location, or creator
- View photo details (location, creator, description, date)
- Offline support (SQLite caching)
- Pagination

## Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **State Management**: Riverpod 2.5.1
- **Database**: SQLite (sqflite)
- **HTTP**: http package
- **Image Caching**: cached_network_image

## Setup

### Prerequisites

- Flutter 3.x
- Dart 3.x

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd photo-gallery-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code:
```bash
flutter pub run build_runner build
```

4. Run the app:
```bash
flutter run
```

Choose in `main.dart`.

## Search

- Filters by location, creator
- Resets pagination on new search

## Pagination

- 10 items per page (configurable)
- Loading indicator shown during fetch

## Database

SQLite caching for offline access:
- Photos cached automatically after API fetch
- Falls back to cache if network unavailable
- Single table: `photos`

## Testing

Run tests:
```bash
flutter test
```

Test files:
- `test/models/photo_test.dart`
- `test/providers/pagination_providers_test.dart`