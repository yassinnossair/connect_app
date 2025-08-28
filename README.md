# **Connect: A Cloud-Native Networking Platform** 🌐



Connect is a full-stack, cross-platform application designed to modernize professional networking. It replaces traditional paper business cards with a seamless digital experience, allowing users to create multiple professional profiles and exchange contact information instantly via QR codes.

---

## **Live Demo** 🚀

You can try the live web version of the application here:

- **[https://connect-final-199ec.web.app](https://connect-final-199ec.web.app)**

---

## **Features** ✨

The application is built around four core epics, providing a complete and intuitive user journey.

### **Epic 1: User Authentication & Onboarding**
- **Secure Sign-Up & Login**: Users can create an account and log in using their email and password.
- **Persistent Sessions**: Users remain logged in even after closing and reopening the app.
- **Password Reset**: A "Forgot Password" option allows users to securely reset their password via an email link.

### **Epic 2: Profile Management**
- **Multiple Profiles**: Users can create and manage multiple professional profiles (e.g., "Work," "Freelance") to suit different networking contexts.
- **Rich Profile Details**: Each profile can be customized with a name, title, company, profile picture, and links to professional networks like LinkedIn or GitHub.
- **Instant Cloud Sync**: All profile updates are saved instantly to the cloud and are reflected across all devices in real-time.

### **Epic 3: Contact Exchange**
- **QR Code Sharing**: Each user has a unique QR code that links to their profile. This code can be displayed for others to scan.
- **In-App Scanner**: A built-in QR code scanner allows users to connect with others quickly.
- **Seamless Request Flow**: Scanning a code initiates a connection request, which the recipient can then accept or decline.

### **Epic 4: Connection Management**
- **Centralized Connection List**: Users have a "My Connections" page that lists all their accepted contacts.
- **View Connection Profiles**: Users can tap on a connection to view all of their professional profiles in a read-only format.

---

## **Screenshots & Demo** 📸

*(Here you can add screenshots or GIFs of the app in action)*

---

## **Technical Architecture** 🏗️

Connect is a full-stack application leveraging Flutter for the frontend and Firebase for the backend. The project follows a clean, multi-layered architecture to ensure a clear separation of concerns, making the codebase scalable and maintainable.

### **Frontend (Flutter)**
- **UI Layer**: Composed of reactive pages built with Flutter widgets. The UI is designed to be clean, modern, and intuitive.
- **Business Logic Layer (BLoC)**: State is managed using the BLoC pattern. There is a clear separation between global state managers (`AuthBloc`) and feature-specific BLoCs (`ProfileBloc`, `ConnectionBloc`), with **Cubit** used for simpler cases (`ConnectionDetailCubit`).
- **Domain Layer**: Defines the application's data models (using **`freezed`**) and the repository "contracts" (interfaces), forming a clear blueprint for the app's business rules.
- **Data Layer**: Provides concrete repository implementations that handle all communication with Firebase services and manage data fetching, caching, and error handling.

### **Backend (Firebase)**
- **Authentication**: Manages user sign-up, login, and sessions using **Firebase Authentication**.
- **Database**: **Cloud Firestore** is used as the primary real-time, NoSQL database for storing all user data, profiles, and connections.
- **Storage**: User-uploaded content, such as profile pictures, is stored securely in **Firebase Storage**.
- **Serverless Functions**: Critical, secure, and transactional logic is handled by a **Cloud Function** (`acceptRequest`). This ensures data integrity and security by running logic in a trusted backend environment.
- **Hosting**: The web version of the application is deployed and hosted using **Firebase Hosting**.

---

## **Technology Stack** 🛠️

### **Core Framework & Services**
- **Framework**: Flutter
- **Backend-as-a-Service**: Firebase (Auth, Firestore, Storage, Cloud Functions, Hosting)

### **Key Flutter Packages**
- **State Management**: `flutter_bloc`
- **Routing**: `go_router`
- **Data Modeling**: `freezed`, `json_serializable`
- **Dependency Injection**: `get_it` (Service Locator)
- **Device & Platform**:
  - `image_picker` (for gallery access)
  - `qr_flutter` & `mobile_scanner` (for QR code functionality)
  - `url_launcher` (for opening external links)

---

## **Firestore Data Structure** 🗂️

The Firestore database is structured to be scalable and efficient, using a combination of top-level collections and sub-collections.

/users/{userId}/
  ├── profiles/{profileId}  // A user's professional profiles
  │     ├── id: "profileId"
  │     ├── name: "Work"
  │     └── ...
  │
  └── connections/{connectionId} // A user's established connections
        ├── id: "connectionId"
        ├── otherUserId: "otherUserId"
        ├── otherUserName: "John Doe"
        └── ...

/connection_requests/{requestId}/ // All pending connection requests
  ├── id: "requestId"
  ├── fromUserId: "senderId"
  ├── toUserId: "receiverId"
  ├── status: "pending" | "accepted" | "declined"
  └── ...