Women Safety App
This project is a Women Safety App built using Flutter with Firebase for authentication and data storage. It allows users to register, log in, upload images, and securely store data in the cloud.

Table of Contents
Features
Getting Started
Prerequisites
Installation
Firebase Setup
Usage
Contributing
License
Features
User Authentication: Login and registration using Firebase Email/Password authentication.
Cloud Storage: Secure image uploads using Firebase Cloud Storage.
Firestore Database: Cloud Firestore for storing and retrieving app data.
Cross-Platform: Works on both Android and iOS.
Getting Started
These instructions will guide you through setting up the project on your local machine for development and testing.

Prerequisites
Ensure you have the following installed:

Flutter SDK: Installation Guide
Firebase Account: Create an Account
Git: Git Installation
Installation
Clone the Repository:


git clone <repository_url>
cd <project_directory>
Install Dependencies:

Run the following command to install all project dependencies:



flutter pub get
Configure App Namespace:

Update the Android and iOS namespaces:

For Android: Edit the android/app/build.gradle file and update the applicationId to com.example.women_safety.
For iOS: Open ios/Runner.xcodeproj in Xcode and update the Bundle Identifier.
Firebase Setup
Create Firebase Project:

Go to Firebase Console, create a new Firebase project, and add your app (Android/iOS).
Download Firebase Configuration Files:

For Android, download google-services.json and place it in android/app/.
For iOS, download GoogleService-Info.plist and place it in ios/Runner/.
Enable Authentication:

In the Firebase Console, go to Authentication and enable Email/Password under the Sign-in Methods.
Enable Firestore or Cloud Storage:

Go to Firestore Database or Storage in Firebase and set up the required database or storage bucket for the app.
Usage
Run the project after completing all the setup steps:


flutter run
