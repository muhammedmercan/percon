# Percon - Travel Application

This case study aims to develop an mobile application using Flutter that enables users to track their travel plans to Germany, Austria, and Switzerland between 2025-2030. The application features Firebase authentication, processes sample JSON data to list travels, and includes functionalities such as adding to favorites, filtering, multi-language support, and an effective user interface.

## Technologies and Libraries

### Architecture & Design Patterns
- **Clean Architecture** - Separation of concerns with domain, data, and presentation layers
- **Repository Pattern** - Abstract data sources behind a common interface
- **MVVM Pattern** - Using ViewModels with Provider for state management
- **Dependency Injection** - Using GetIt for service locator pattern

### Core Features
- **Firebase Authentication** - Google Sign-in integration
- **Local Database** - SQLite implementation using sqflite
- **Multi-language Support** - Localization for German, Turkish, and English
- **Offline First** - Complete functionality even without internet connection

### Key Libraries
#### State Management & DI
- `provider` - For MVVM implementation and state management
- `get_it` - Dependency injection and service location

#### Firebase Integration
- `firebase_core` - Firebase initialization
- `firebase_auth` - Authentication services
- `google_sign_in` - Google authentication integration

#### Local Storage
- `sqflite` - SQLite database implementation
- `shared_preferences` - Local key-value storage

## Features
- **User Authentication**
  - Google Sign-in
  - User profile management
  - Last login tracking

- **Travel Management**
  - View and filter travels
  - Favorite travels
  - Pagination support
  - Multi-criteria filtering

- **Data Management**
  - Local database caching
  - Automatic data synchronization

- **Multi-language Support**
  - German (Default)
  - Turkish
  - English



