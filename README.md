# My Rest Admin

Admin panel for the **my_resturant** platform. A Flutter application that lets the platform administrator manage restaurants, promo codes, and generate reports.

## Features

- **Authentication** — Admin-only sign in via Supabase Auth. Non-admin accounts are rejected after a quick authorization check.
- **Restaurants** — Browse, search, and add restaurant accounts alongside summary stats (total, active, etc.).
- **Promo Codes** — Create and manage promotional codes for the platform.
- **Reports** — View platform-level reports and restaurant summary metrics.
- **Responsive UI** — Adapts between mobile (bottom nav bar) and tablet/desktop (navigation rail) layouts.
- **Offline awareness** — Connectivity banner when the device loses network access.
- **Polished UX** — Liquid glass navigation bar, shimmer loading skeletons, entrance animations, press animations, and confirm dialogs.
- **Branding** — The brand logo (`assets/images/resticon.png`) is used as the in-app logo, Android launcher icon, and splash screen.

## Tech Stack

- **Flutter** — UI framework (Material 3, custom theme with the `NRT` font family)
- **Supabase** — Backend (Auth, Postgres via `postgrest`)
- **shared_preferences** — Local persistence
- **connectivity_plus** — Network status detection
- **shimmer** — Loading skeleton effects

## Getting Started

### Prerequisites

- Flutter SDK (3.12 or later, matching `pubspec.yaml`)
- A Supabase project set up with Auth and the platform's schema

### Setup

1. Clone the repository and install dependencies:

   ```sh
   flutter pub get
   ```

2. Configure Supabase credentials in `lib/config/supabase_config.dart`:

   ```dart
   class SupabaseConfig {
     static const String url = 'YOUR_SUPABASE_URL';
     static const String anonKey = 'YOUR_PUBLISHABLE_KEY';
   }
   ```

3. Run the app:

   ```sh
   flutter run
   ```

## Project Structure

```
lib/
├── config/          # Supabase configuration
├── core/            # Shared helpers (responsive, theme colors)
├── data/            # Data layer / admin repository
├── models/          # Data models (reports, restaurant, promo codes)
├── pages/           # Screens (login, home, restaurants, promo codes, reports)
├── theme/           # App theme
├── utils/           # Formatting utilities
└── widgets/         # Reusable widgets (logo, nav bar, dialogs, skeletons)
```

## Branding / Assets

- **App logo**: `assets/images/resticon.png`
- **Android launcher icon**: generated from the logo into `android/app/src/main/res/mipmap-*/`
- **Splash screen**: centered logo (`launch_image.png`) in `android/app/src/main/res/`
- **In-app logo widget**: `lib/widgets/app_logo.dart` renders the logo image directly

To update the branding, replace `assets/images/resticon.png` and regenerate the Android launcher/splash assets, or use `flutter_launcher_icons` / `flutter_native_splash`.
