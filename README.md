# Furniture Mobile Application (Flutter + Firebase)

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Firebase Setup](#firebase-setup)
- [Contributing](#contributing)
- [License](#license)

## Introduction
The Furniture Mobile Application is a mobile app developed using Flutter and Firebase that allows users to browse and purchase furniture products online. It provides a user-friendly interface for searching, viewing, and ordering furniture items from the app. The app is built using Flutter, a popular cross-platform framework, and it utilizes Firebase for backend services like authentication, database management, and storage.

## Features
The Furniture Mobile Application offers the following features:
- User registration and authentication: Users can create accounts and log in securely to access the app's features.
- Product browsing: Users can browse through a catalog of furniture items with details like images, descriptions, prices, and ratings.
- Product search: Users can search for specific furniture items using keywords or filters.
- Product details: Users can view detailed information about each furniture item, including multiple images, specifications, customer reviews, and ratings.
- Shopping cart: Users can add products to a shopping cart and manage the cart by adding or removing items.
- Checkout process: Users can proceed to the checkout process to place orders, enter shipping details, and make payments.
- Order history: Users can view their order history and track the status of their orders.
- User reviews and ratings: Users can leave reviews and ratings for products they have purchased.
- Wishlist: Users can save their favorite products to a wishlist for future reference.
- Push notifications: Users can receive notifications about order status updates, promotions, and new product arrivals.

## Technologies Used
The Furniture Mobile Application is developed using the following technologies:
- Flutter: A cross-platform framework for building native mobile applications.
- Dart: The programming language used by Flutter for app development.
- Firebase: A comprehensive development platform provided by Google, which includes services like Firebase Authentication, Firebase Realtime Database, Firebase Cloud Firestore, and Firebase Cloud Messaging.

## Installation
To install and run the Furniture Mobile Application on your machine, follow these steps:

1. Install Flutter: Refer to the official Flutter installation guide (https://flutter.dev/docs/get-started/install) to install Flutter on your development machine.

2. Clone the repository: Use Git or any other version control tool to clone the repository to your local machine.

3. Install dependencies: Open a terminal or command prompt, navigate to the project's root directory, and run the following command to install the project dependencies:

   ```
   flutter pub get
   ```

4. Run the app: Connect a mobile device or start an emulator/simulator, and run the following command to launch the app:

   ```
   flutter run
   ```

The app should now be up and running on your device/emulator.

## Usage
Upon launching the Furniture Mobile Application, users can navigate through the various screens and perform the following actions:

- Create an account or log in using existing credentials.
- Browse the catalog of furniture products.
- Use the search feature to find specific furniture items.
- View detailed information, images, reviews, and ratings of individual products.
- Add products to the shopping cart.
- Proceed to checkout and make payments.
- View order history and track order status.

## Firebase Setup
To set up the Firebase backend for the Furniture Mobile Application, follow these steps:

1. Create a Firebase project: Go to the Firebase Console (https://console.firebase.google.com

) and create a new project.

2. Set up Firebase Authentication: In the Firebase Console, navigate to the "Authentication" section and enable the desired authentication methods (e.g., email/password, Google Sign-In). Make sure to follow the instructions provided to set up each authentication method.

3. Set up Firebase Database: Choose either Firebase Realtime Database or Firebase Cloud Firestore as the database backend for the app. Create the necessary collections and documents to store the furniture product data.

4. Set up Firebase Storage: Enable Firebase Cloud Storage to store and retrieve furniture product images. Follow the Firebase documentation to set up the required storage rules and upload sample images.

5. Set up Firebase Cloud Messaging: To enable push notifications, set up Firebase Cloud Messaging and configure the necessary platform-specific settings for Android and iOS. Follow the Firebase documentation for detailed instructions.

6. Configure the app with Firebase: Update the Flutter project's configuration files (e.g., `google-services.json` for Android, `GoogleService-Info.plist` for iOS) with the Firebase project-specific settings generated in the Firebase Console.

7. Integrate Firebase in the Flutter app: Use the Firebase SDKs and plugins for Flutter to integrate Firebase services like authentication, database access, storage, and push notifications. Refer to the respective Flutter and Firebase documentation for implementation details.

## Contributing
Contributions to the Furniture Mobile Application are welcome! If you encounter any issues or have suggestions for improvements, please submit them to the project's issue tracker on GitHub. If you'd like to contribute code, please fork the repository and create a pull request with your proposed changes.

## License
The Furniture Mobile Application is released under the [MIT License](https://opensource.org/licenses/MIT). You are free to use, modify, and distribute the code for both commercial and non-commercial purposes.