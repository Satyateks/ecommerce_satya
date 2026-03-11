# ecommerce_satya

This is a simple e-commerce mobile application built using Flutter.
The main goal of this project is to demonstrate how to fetch product data from an API, display it in a mobile UI, and allow users to interact with it through features like viewing product details and adding items to a cart.

Users can browse products, check detailed information about each product, add them to the cart, and go through a basic checkout flow.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



---

# 📱 Features

### Product Listing

* Fetches products from API
* Displays:

  * Product Image
  * Title
  * Category
  * Price
* Loading indicator while fetching data
* Error handling with retry option

### Product Detail

* Displays:

  * Product image
  * Title
  * Category
  * Description
  * Price
  * Rating
* **Add to Cart** functionality

### Cart

* Shows added products
* Quantity controls (+ / −)
* Remove item from cart
* Line total for each item
* Cart total amount
* Checkout confirmation dialog

---

# 🛠 Tech Stack

* **Flutter**
* **Dio** → API requests
* **GetX** → State management & navigation

---

# 📂 Project Structure

```
lib
 ├── main.dart
 ├── app
 │    ├── app.dart
 │    └── routes.dart
 ├── models
 │    ├── product_model.dart
 │    └── cart_item_model.dart
 ├── services
 │    └── product_service.dart
 ├── controllers
 │    ├── cart_controller.dart
 │    └── product_controller.dart
 ├── screens
 │    ├── product_list_screen.dart
 │    ├── product_detail_screen.dart
 │    └── cart_screen.dart
 ├── widgets
 │    ├── product_card.dart
 │    ├── cart_item_tile.dart
 │    ├── loading_widget.dart
 │    └── error_view.dart
 └── utils
      └── constants.dart
```

---

# 🌐 API

Products are fetched from:

https://fakestoreapi.com/products

---

# 🚀 Setup & Run Instructions

### 1. Clone the repository

```
git clone <your-repository-url>
```

### 2. Navigate to the project

```
cd ecommerce_satya
```

### 3. Install dependencies

```
flutter pub get
```

### 4. Run the app

```
flutter run
```

---

# 🧠 Architecture

The application follows a **clean and modular architecture**:

* **Services** → Handles API communication
* **Controllers (Controller)** → Manages application state using GetX
* **Models** → Represents structured data from the API
* **Screens** → UI pages of the application
* **Widgets** → Reusable UI components
* **Utils** → Constants and helper classes

This structure improves maintainability and scalability.

---

# ⚠️ Known Limitations

* No persistent cart storage
* No real payment integration
* No product search or filtering
* No user authentication
* Limited offline handling

---

# 🔮 Future Improvements

* Product search functionality
* Category filters
* Local storage for cart persistence
* Wishlist / favorites feature
* Pagination for large product lists
* Better UI animations
* Unit and widget testing
* Dark mode support

---

# 📌 Notes

* This project was created as part of a **mobile developer assignment**.
* The focus was on **clean architecture, state management, API integration, and maintainable code structure**.

---
# ecommerce_satya
