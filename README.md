# Weather Forecast App

This is a mobile weather forecast application designed with flexibility and modularity in mind. The app supports loading weather data from different sources and displaying it consistently within a unified UI.

---

## 🔄 API Change Decision

Originally, the app was intended to use the Marvel API for demonstration. However, due to its consistent failures at the start of the test project, the decision was made to switch to the **OpenWeather API** instead.

---

## 💡 Project Overview

The goal was to implement a weather app capable of consuming weather data from multiple sources using a unified, clean, and scalable architecture. This was achieved using **Dependency Injection (DI)**, which enables the easy addition of new services.

While AccuWeather integration was planned, time constraints led to focusing on OpenWeather for the initial release. However, the architecture is built to support future integrations seamlessly.

---

## ✅ Key Implementation Details

### 1. 🔧 Initial Setup and API Client

- The initial base code and API client were implemented first.
- A crash caused by force unwrapping an optional was fixed.
- Model deserialization logic was moved into the **Data Layer**.
- **Dependency Injection (DI)** was introduced early to support mocking of `URLSession` and other dependencies for unit testing.

---

### 2. 🧱 Layered Architecture Refactor

- The entire dependency chain from **View → Presenter/ViewModel → API Client** was refactored and renamed to align with actual models and dependencies.

---

### 3. 🧠 Memory Management

- A **retain cycle** was identified and resolved in the `ListHeroPresenter` (renamed to `LocationsListPresenter`), fixing a memory leak.

---

### 4. ⏱️ Async/Await Migration

- All possible API calls were migrated from closure-based syntax to `async/await`.
- An exception was `LocationsSearch`, which uses `MKLocalSearchCompleter`. Since it only provides a delegate-based API (with no guarantee that the delegate will always be called), attempts to wrap it using `withCheckedContinuation` caused leaks and were abandoned.

---

### 5. 🧼 View Updates

- Existing views were lightly updated to improve conformance to **Object-Oriented Programming (OOP)** principles.

---

### 6. 📐 MVVM for SwiftUI Modules

- For SwiftUI-based modules, the **MVVM** pattern was adopted for its clean separation of concerns and strong compatibility with SwiftUI.

---

### 7. 🛠️ Error Handling

- Error handling and mapping to **custom error types** were introduced in the API client.
- Errors are now categorized into:
  - **Recoverable errors** – shown to the user with a retry option.
  - **Non-recoverable errors** – prompt the user to consider switching the service.

---

### 8. 🔗 Navigation & Wireframe Management

- In MVVM modules, `unowned` references are used for the `UINavigationController` inside wireframes.
- This prevents **retain cycles** in the navigation flow.

---

## 🔍 Summary

This project showcases a scalable and testable architecture for weather-based applications using:

- `async/await`
- Clean layering (View ↔ ViewModel/Presenter ↔ Service ↔ API Client)
- Dependency Injection
- SwiftData
- MVVM (for SwiftUI)
- UIKit and MVP

---

## 🚧 Future Work

- Add AccuWeather support as a new service
- Expand UI error handling states
- Improve offline caching
- Add test coverage
- Migrate UIKit views to SwiftUI


