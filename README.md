# 🛍️ MOOL Shopping App

<div align="center">
  <img src="app/assets/home_feed.png" alt="MOOL Logo" width="300"/>
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.5.0-blue.svg)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.5.0-blue.svg)](https://dart.dev)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
</div>

---

## 📱 About

**MOOL** is a modern, feature-rich e-commerce mobile application built with Flutter.  
Designed with a sleek dark theme and intuitive user interface, it provides a seamless shopping experience for users to browse, search, and purchase products online.

---

## ✨ Features

### 🏪 Core Shopping Features
- **Product Catalog** – Browse through various product categories
- **Search & Filter** – Advanced search functionality with filtering options
- **Product Details** – View images, descriptions, and reviews
- **Shopping Cart** – Add, remove, and manage items
- **Favorites** – Save products for quick access
- **User Reviews** – Read and submit reviews with ratings

### 👤 User Management
- **User Authentication** – Sign up, sign in, and account verification
- **Profile Management** – Update personal details and preferences
- **Address Book** – Manage multiple shipping addresses
- **Order History** – Track current and past orders
- **Notifications** – Get updates on orders and promotions

### 💳 Commerce Features
- **Checkout Process** – Streamlined checkout with multiple payment options
- **Payment Integration** – Visa, MasterCard, Paymob
- **Multi-Currency** – Prices in Saudi Arabian Riyal (SAR)
- **Country Selection** – Supports Egypt, KSA, UAE

### 🎨 UI/UX Features
- **Dark Theme** – Modern dark interface design
- **Smooth Animations** – Fluid user interactions
- **Carousel Banners** – Display promotional content
- **Bottom Navigation** – Quick access to main sections

---

## 🏗️ Architecture

### 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── constants/                # App constants and configurations
├── cubit/                    # State management (BLoC pattern)
│   ├── product_cubit.dart
│   └── cart_cubit.dart
├── data/                     # Data layer and repositories
│   ├── cart/
│   └── productdetails/
├── models/                   # Data models
│   ├── product.dart
│   ├── cart_item.dart
│   └── order.dart
├── screens/                  # UI screens
│   ├── splash.dart
│   ├── welcome.dart
│   ├── home.dart
│   ├── auth.dart
│   ├── cart.dart
│   ├── checkout.dart
│   ├── profile.dart
│   └── products/
└── widgets/                  # Reusable UI components
    ├── bottom_navbar.dart
    ├── item_card.dart
    ├── button.dart
    ├── text_field.dart
    └── Components/
```

### 🏛️ Design Patterns
- **BLoC Pattern** – State management using `flutter_bloc`
- **Repository Pattern** – Data abstraction layer
- **Component-Based Architecture** – Reusable UI widgets
- **Material Design** – Google’s design principles

---

## 🛠️ Tech Stack

### 📚 Dependencies

| Package             | Version   | Purpose                |
|---------------------|-----------|------------------------|
| `flutter_bloc`      | ^8.0.0    | State management       |
| `intl`              | ^0.17.0   | Internationalization   |
| `google_fonts`      | ^4.0.0    | Custom fonts           |
| `carousel_slider`   | ^5.0.0    | Image carousels        |
| `cupertino_icons`   | ^1.0.8    | iOS-style icons        |

---

## 🚀 Getting Started

### 📋 Prerequisites
- **Flutter SDK** – 3.5.0 or higher  
- **Dart SDK** – 3.5.0 or higher  
- **IDE** – VS Code or Android Studio  

### 🔧 Installation
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Shopping-App/app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # Development
   flutter run
   
   # Specific platform
   flutter run -d chrome     # Web
   flutter run -d android    # Android
   flutter run -d ios        # iOS
   ```
