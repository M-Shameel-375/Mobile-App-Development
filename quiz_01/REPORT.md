# Quiz-1: Firebase Authentication App Report

## Project Overview
A Flutter application demonstrating Firebase Email/Password authentication with login, signup, and home screens.

---

## Project Structure

```
lib/
├── main.dart                    # App entry point & AuthGate
├── firebase_options.dart        # Firebase configuration (Android & Web)
├── screens/
│   ├── login_screen.dart        # Login form UI
│   ├── signup_screen.dart       # Sign up form UI
│   └── home_screen.dart         # Home screen with logout
├── services/
│   └── auth_service.dart        # Firebase Auth wrapper service
└── widgets/
    └── custom_textfield.dart    # Reusable text field widget
```

---

## Firebase Configuration

| Property           | Value                                      |
|--------------------|--------------------------------------------|
| Project ID         | `fir-authapp-374ee`                        |
| Project Number     | `350201261802`                             |
| API Key            | `AIzaSyC_I2tSAS4LgVb41PQACQlthd9OzNO1VpA`  |
| Auth Domain        | `fir-authapp-374ee.firebaseapp.com`        |
| Storage Bucket     | `fir-authapp-374ee.firebasestorage.app`    |
| Auth Provider      | Email/Password (Enabled)                   |

---

## Screenshots

> **Instructions:** Add your screenshots in the sections below.

### 1. Login Screen (Correct Credentials)
<!-- Add screenshot here -->
![Login Success](screenshots/login_success.png)

**Description:** User enters valid email and password, successfully logs in and is redirected to Home screen.

---

### 2. Login Screen (Wrong Credentials)
<!-- Add screenshot here -->
![Login Error](screenshots/login_error.png)

**Description:** User enters invalid credentials, error message "Invalid email or password." is displayed.

---

### 3. Sign Up Screen
<!-- Add screenshot here -->
![Signup Screen](screenshots/signup_screen.png)

**Description:** New user registration form with email and password fields.

---

### 4. Sign Up (Email Already Registered)
<!-- Add screenshot here -->
![Signup Error](screenshots/signup_error.png)

**Description:** Error message "That email is already registered." is shown when user tries to register with existing email.

---

### 5. Home Screen (After Login)
<!-- Add screenshot here -->
![Home Screen](screenshots/home_screen.png)

**Description:** Welcome screen showing logged-in user's email with a red Logout button.

---

### 6. Firebase Console - Authentication
<!-- Add screenshot here -->
![Firebase Console](screenshots/firebase_auth.png)

**Description:** Firebase Console showing Email/Password authentication enabled and registered users.

---

## Code Summary

### main.dart
- Initializes Firebase with platform-specific options
- `AuthGate` widget listens to `authStateChanges` stream
- Automatically navigates to Home if user is signed in, otherwise shows Login
- Debug banner removed (`debugShowCheckedModeBanner: false`)

### auth_service.dart
- Singleton service wrapping `FirebaseAuth`
- Methods: `signIn()`, `signUp()`, `signOut()`
- Validates credentials before calling Firebase
- Maps Firebase error codes to user-friendly messages

### login_screen.dart
- Form with email/password validation
- Shows loading indicator during authentication
- Displays error messages on failure
- Link to navigate to Sign Up screen

### signup_screen.dart
- Form with email/password validation
- Creates new user account via Firebase
- Auto-login after successful registration
- Link to navigate back to Login screen

### home_screen.dart
- Displays welcome message and user email
- Red Logout button that signs out user
- `AuthGate` automatically redirects to Login after sign out

### custom_textfield.dart
- Reusable `TextFormField` widget
- Supports label, keyboard type, obscure text, and validation

---

## How to Run

```bash
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Run on Android
flutter run -d android
```

---

## Author
**Student Name:** ________________________  
**Roll Number:** ________________________  
**Date:** November 29, 2025

---
