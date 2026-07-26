# Cloudy ☁️

A clean, native iOS weather app built with SwiftUI. Cloudy shows the current
conditions, an hourly breakdown, and a multi-day forecast for your current
location or any place you search for and save.

## Demo

[![Watch the demo on YouTube](https://img.shields.io/badge/YouTube-Watch%20Demo-red?style=for-the-badge&logo=youtube)](https://youtube.com/shorts/bBSdiB-K9Hs)

## Features

- **Current location weather** — automatically detects your location and shows
  the current conditions on launch.
- **Search & save locations** — search for any city and keep a list of your
  favorite places (persisted on-device with SwiftData).
- **Hourly forecast** — a dedicated screen with the hour-by-hour outlook.
- **Multi-day forecast** — a 3-day forecast at a glance.
- **Weather details** — humidity, wind, and other condition details in tidy
  cards.
- **Dynamic backgrounds** — the background adapts to the time of day
  (morning / evening).
- **Custom typography** — bundled Inter font family throughout the UI.

## Tech Stack

- **Language:** Swift
- **UI:** SwiftUI
- **Minimum iOS:** 18.5
- **Persistence:** SwiftData (for saved locations)
- **Location:** CoreLocation
- **Dependency Injection:** [Swinject](https://github.com/Swinject/Swinject) 2.10.0 (via Swift Package Manager)
- **Weather data:** [WeatherAPI.com](https://www.weatherapi.com/)

## Architecture

Cloudy follows a layered, Clean Architecture–inspired structure with MVVM in
the presentation layer:

```
Cloudy/
├── App/                 # App entry point (CloudyApp)
├── Core/                # Cross-cutting infrastructure
│   ├── DI/              # Swinject dependency container
│   ├── Location/        # LocationService (CoreLocation wrapper)
│   ├── Network/         # NetworkManager, RequestInterceptor, Keychain, errors
│   ├── Theme/           # Colors & fonts
│   └── Views/           # Reusable views (background, network image, error)
├── Data/                # Data layer
│   ├── DTO/             # API response models
│   ├── DataSource/      # WeatherRemoteDataSource
│   └── Repositories/    # WeatherRepo (implements domain protocol)
├── Domain/              # Business layer
│   ├── Models/          # Domain models (Weather, Forecast, SavedLocation…)
│   └── Repositories/    # Repository protocols
├── Presentation/        # SwiftUI screens & view models
│   └── Views/
│       ├── Home/        # Home & hourly screens + components
│       └── Locations/   # Locations list & search
└── Resources/           # Assets, fonts, Info.plist, config
```

**Data flow:** `View → ViewModel → Repository (protocol) → RemoteDataSource → NetworkManager → WeatherAPI`

Dependencies are wired together in [`DIContainer.swift`](Cloudy/Core/DI/DIContainer.swift)
and resolved where needed.

## Getting Started

### Prerequisites

- Xcode 16+ with iOS 18.5 SDK
- A free API key from [WeatherAPI.com](https://www.weatherapi.com/)

### Setup

1. **Clone the repository**
   ```bash
   git clone <repo-url>
   cd Cloudy
   ```

2. **Add your API key**

   The app reads the key from a `Secrets.xcconfig` file (which is git-ignored).
   Create the file at `Cloudy/Resources/Secrets.xcconfig`:

   ```
   WEATHER_API_KEY = your_api_key_here
   ```

   The key is injected into `Info.plist` via the `WEATHER_API_KEY` build
   setting, then stored securely in the Keychain on first launch (see
   [`CloudyApp.swift`](Cloudy/App/CloudyApp.swift)).

3. **Open and run**
   ```bash
   open Cloudy.xcodeproj
   ```
   Select a simulator (or device) and press **⌘R**. Swift Package Manager will
   resolve Swinject automatically.

## How It Works

- On launch, Cloudy tries to use your **current location**. If location access
  is unavailable, it falls back to the last selected location (or `Cairo` by
  default).
- Selecting a location from the **Locations** screen pins it as your active
  place; choosing **Current Location** switches back to GPS-based weather.
- Saved locations are stored locally with **SwiftData** and survive app
  restarts.
