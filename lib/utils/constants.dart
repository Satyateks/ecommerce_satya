import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Mini E-Commerce';
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';

  static double screenPadding(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.04;
  }

  static double cardRadius(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.02;
  }

  static double imageHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.18;
  }

  static const Duration animationDuration = Duration(milliseconds: 250);
}

class AppColors {
  static const Color primary = Colors.blue;
  static const Color background = Color(0xFFF8F9FB);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color error = Colors.red;
  static const Color success = Colors.green;
}

class AppTextStyles {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle priceText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );
}