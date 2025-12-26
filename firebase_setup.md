# Firebase Setup Guide 🔥

## 1. Project Creation
* Created a new project on [Firebase Console](https://console.firebase.google.com/).
* Project Name: `Laza-App`.

## 2. Authentication
* Enabled **Email/Password** provider.
* Enabled **Anonymous** auth (for Guest/Social login simulation).

## 3. Cloud Firestore
* Created a database in **Test Mode**.
* Defined collections structure:
    * `users/{uid}`
    * `carts/{uid}/items/{productId}`
    * `favorites/{uid}/items/{productId}`
    * `orders/{autoId}`

## 4. Flutter Configuration
* Added `firebase_core`, `firebase_auth`, `cloud_firestore` to `pubspec.yaml`.
* **Android**: Downloaded `google-services.json` and placed it in `android/app/`.
* **iOS**: Downloaded `GoogleService-Info.plist` and placed it in `ios/Runner/`.