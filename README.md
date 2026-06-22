# Flutter Boilerplate Project

A starter template for building scalable, fast-loading Flutter apps on **Android** and **iOS**.  
This boilerplate is designed for **lightweight applications, rapid prototyping, and high-speed development**.

---

## ✨ Features
- 🌗 **Dynamic Theme**: Built-in support for light and dark modes.
- 🏗️ **Build Flavours**: Easily configure multiple environments (dev, staging, prod) out of the box.
- 🚀 **Speed-Focused Utilities**: Common helpers for rapid application deployment.
- 📱 **Cross-Platform**: Works seamlessly on Android and iOS.
- 🧩 **Modular Structure**: Clean structure for maintainability and scalability.

---

## 🛠️ Technical Specifications

This boilerplate comes pre-configured with a carefully selected architecture stack optimized for speedy development cycles:

* **State Management (GetX):** Powered by GetX. By design, **all controllers stay in memory** throughout the application lifecycle to facilitate instant data accessibility and minimize reactivity overhead.
* **Custom Routing:** Built-in decoupled, named-route management setup allowing for fluid screen transitions and simple deep-linking capabilities.
* **API Service Layer:** A clean, centralized HTTP/Dio client layout designed to easily attach interceptors, map tokens, and process JSON payloads instantly.
* **Android Build Flavors:** Deeply integrated native Gradle flavor configurations to separate API endpoints, package names, and app icons for Dev, Staging, and Production tracks right from the terminal.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio / Xcode
- Git

### Installation
```bash
# Clone the repository
git clone [https://github.com/](https://github.com/)<your-username>/<repo-name>.git

# Navigate into the project
cd <repo-name>

# Install dependencies
flutter pub get