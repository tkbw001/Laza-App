# Appium Test Cases 🧪

## Tools Used
* **Appium Server**: v2.0
* **Node.js**: v18.0
* **WebDriverIO**: Client library
* **Device**: Android Emulator (Pixel 4 API 30)

## Test Case 1: Authentication Flow
* **Description**: Verify that a user can log in successfully and navigate to Home.
* **Pre-conditions**: User account must exist in Firebase Auth.
* **Steps**:
    1. Open App.
    2. Navigate to Login Screen.
    3. Enter valid Email and Password.
    4. Click Login.
* **Expected Result**: User is redirected to Home Screen ("Laza" title visible).

## Test Case 2: Cart Functionality
* **Description**: Verify adding a product to the cart.
* **Pre-conditions**: User must be logged in.
* **Steps**:
    1. Browse products on Home Screen.
    2. Click on a product to view details.
    3. Click "Add to Cart".
    4. Navigate to Cart Screen.
* **Expected Result**: The added product appears in the Cart list.