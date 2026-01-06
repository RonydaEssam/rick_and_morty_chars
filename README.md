# Rick and Morty characters app
A simple app displaying Rick and Morty's characters and their details.

## Architecture Overview
This project follows a Layered Architecture to ensure a clean separation of concerns:
    **Presentation Layer:** Pure UI components and screens.
    **Business Logic (Cubit):** Uses the Bloc pattern to manage state transitions independently of the UI.
    **Data Layer:** Handles API calls via web_services and maps them to models, providing data to the rest of the app through the repository pattern.

```
lib/
├── business_logic/          # State Management layer (Cubit)
│   └── cubit/               # Manages app state and emits UI updates
├── constants/               # Global configuration and styling
│   ├── app_colors.dart      # Centralized theme colors
│   └── strings.dart         # Static strings and API endpoints
├── data/                    # Data Layer (External interactions)
│   ├── models/              # Data classes and JSON serialization
│   ├── repository/          # Bridges Data Sources and Business Logic
│   └── web_services/        # Network requests (e.g., Dio/Retrofit)
├── presentation/            # UI Layer (Widgets and Screens)
│   ├── screens/             # Main application pages
│   └── widgets/             # Reusable UI components
├── app_router.dart          # Centralized navigation management
└── main.dart                # Application entry point
```