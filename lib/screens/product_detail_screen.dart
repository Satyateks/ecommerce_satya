import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments as ProductModel;
    final CartController cartController = Get.find<CartController>();

    final double price = product.price ?? 0.0;
    final double rating = product.rating?.rate ?? 0.0;
    final int ratingCount = product.rating?.count ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.cardRadius),
              ),
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return const Center(
                    child: Icon(Icons.broken_image_outlined, size: 70),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.title ?? 'No Title',
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              product.category ?? 'Unknown Category',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  '₹ ${price.toStringAsFixed(2)}',
                  style: AppTextStyles.priceText.copyWith(fontSize: 22),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 18, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        '$rating ($ratingCount)',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              product.description ?? 'No description available',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  cartController.addToCart(product);
                  Get.snackbar(
                    'Success',
                    'Product added to cart',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(12),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}