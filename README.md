# Gaia nutrition plans
## Overview
Flutter/Dart app for creating and managing meal plans with local storage (SQFlite) and cloud sync (Supabase). Features Stripe payment, state management via GetX, Clean Architecture & MVVM patterns, fetching foods from USDA FDC API, AI-generated meal plans using Cohere API, and light/dark theme switching.

## Technologies Used
### Flutter / Dart
Flutter is an open source framework for building beautiful, natively compiled, multi-platform applications from a single codebase.
### SQFlite (Local Storage)
Sqflite is a popular package for implementing SQLite databases in Flutter. It provides a simple and efficient way to store and retrieve data from local storage, making it ideal for mobile
applications that require offline data access.
### Supabase (Cloud Storage)
Supabase is the Postgres development platform.Start your project with a Postgres database, Authentication, instant APIs, Edge Functions, Realtime subscriptions, Storage, and Vector embeddings.
### Stripe (Payment Gateway)
The Stripe Flutter SDK allows to build delightful payment experiences in native Android and iOS apps using Flutter. provide powerful and customizable UI screens and elements that can be used out-of-the-box to collect users' payment details.
### GetX (State Management)
GetX is an extra-light and powerful solution for Flutter. It combines high-performance state management, intelligent dependency injection, and route management quickly and practically.
Get has two different state managers: the simple state manager (we'll call it GetBuilder) and the reactive state manager (GetX/Obx).
### GetStorage (Local Settings Storage)
A fast, extra light and synchronous key-value in memory, which backs up data to disk at each operation. It is written entirely in Dart and easily integrates with Get framework of Flutter.
Supports Android, iOS, Web, Mac, Linux, and fuchsia and Windows. Can store String, int, double, Map and Lis
### Clean Architecture & MVVM
Clean Architecture is a software design pattern that separates the application into distinct layers (Presentation, Domain, and Data), ensuring high testability, maintainability, and scalability. Combined with MVVM (Model-View-ViewModel), it allows for clear separation of concerns, making UI and business logic independent.
### USDA FDC API (Food Data)
The USDA FoodData Central API provides comprehensive nutrition information about foods. It allows the application to fetch detailed nutrient data, food categories, and serving sizes to accurately generate meal plans and track user dietary intake.
### Cohere AI API (AI Meal Plan Generation)
Cohere AI API is a natural language processing API that can generate text-based outputs. In this project, it is used to generate automated meal plans based on user preferences, dietary restrictions, and nutritional goals.
### Light/Dark Theme Switching
Flutter provides built-in support for light and dark themes. This feature allows the application to dynamically switch between themes, enhancing user experience and accessibility based on user preference or system settings.
### infinite_scroll_pagination (Paginated Lists)
Unopinionated, extensible and highly customizable package to help you lazily load and display small chunks of items as the user scrolls down the screen – known as infinite scrolling pagination, endless scrolling pagination, auto-pagination, lazy loading pagination, progressive loading pagination, etc.

## Features
### Sign in / Sign up
Allows users to securely create a new account or log in to an existing one. Supports authentication via email/password and integrates with Supabase for secure user management and session handling.
<p float="left">
  <img src="readme_images/Screenshot_20251003_155814_com_example_gaia_nutrition_plans_MainActivity.jpg" alt="Log in page" width="250" />
  <img src="readme_images/Screenshot_20251003_155930_com_example_gaia_nutrition_plans_MainActivity.jpg" alt="Create account page" width="250" />
  
### Payment / Subscription Activation
Enables users to securely pay for and activate their subscription within the app. Integrates with **Stripe** to provide a seamless payment experience, supporting multiple payment methods. The feature ensures secure handling of payment data and updates the user’s subscription status instantly upon successful payment.
<p float="left">
  <img src="readme_images/Screenshot_20251003_161739_com_example_gaia_nutrition_plans_PaymentSheetActivity.jpg" alt="Payment step 1" width="250" />
  <img src="readme_images/Screenshot_20251003_161807_com_example_gaia_nutrition_plans_PaymentSheetActivity.jpg" alt="Payment step 2" width="250" />
  <img src="readme_images/Screenshot_20251003_161811_com_example_gaia_nutrition_plans_PaymentSheetActivity.jpg" alt="Payment step 3" width="250" />
</p>
  
</p>

**Payment / Subscription Activation Flow**

The app provides a secure and seamless payment process for activating user subscriptions. The flow is as follows:

1. **Initiate Payment Intent**  
   The user selects the desired product. The app calls a Supabase Edge Function to create a payment intent, securely storing the secret key. The function returns the necessary payment details to the app.

2. **Confirm Payment**  
   After receiving the payment details, the user confirms the transaction within the app.

3. **Stripe Webhook Notification**  
   Stripe notifies the system via a webhook once the payment is successfully completed.

4. **Activate Subscription**  
   The webhook-invoked function updates the user's subscription status in the database, activating the subscription immediately.
<p align="center">
  <img src="readme_images/Screenshot_20251001_163740.jpg" alt="Payment Flow Diagram" width="600" />
</p>

### Food Data Retrieval & Local Storage
The app fetches detailed food information from the USDA FoodData Central (FDC) API via a Supabase Edge Function. This ensures the API key is securely stored on the server and never exposed in the client app. The retrieved food data is then saved locally using SQFlite, allowing users to access nutritional information offline and enabling fast, responsive meal plan generation.  

**Flow:**  
1. The app calls a Supabase Edge Function to request food items and their nutritional information from the USDA FDC API.  
2. The Edge Function securely uses the API key to fetch the data and returns the results to the app.  
3. The app parses the returned data and saves it into the local SQLite database using SQFlite.  
4. The locally stored data is then used for meal planning, search, and other app features without requiring repeated network calls.  
<p float="left">
  <img src="readme_images/Screenshot_20251003_170455_com_example_gaia_nutrition_plans_MainActivity.jpg" alt="Food list screen" width="250" />
  <img src="readme_images/Screenshot_20251003_170502_com_example_gaia_nutrition_plans_MainActivity.jpg" alt="Food details screen" width="250" />
</p>
