# Laza - E-commerce Mobile App 🛍️

A simplified MVP for an E-commerce mobile application built with **Flutter** and **Firebase**.

## 🚀 Features
- **Authentication**: Sign up, Login, Forgot Password, and Guest Login (via Social buttons).
- **Products**: Browse products fetched from **Platzi Fake Store API**.
- **Search**: Local search and filtering for products.
- **Cart & Wishlist**: Add/remove items with real-time **Firestore** synchronization.
- **Checkout**: Mock checkout flow with order history archiving.

## 🛠️ Tech Stack
- **Framework**: Flutter (Dart)
- **Backend**: Firebase (Auth, Firestore)
- **State Management**: StatefulWidgets & Streams
- **API**: HTTP package

## 📂 Project Structure
- `lib/screens`: UI screens (Home, Cart, Details, etc.)
- `lib/services`: Logic for API and Firebase (StoreService, ApiService).
- `lib/models`: Data models (ProductModel).

## 🧪 Testing
Appium test scripts are located in the `/appium_tests` directory.