import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../utils/constants.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_widget.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.cart);
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
                if (cartController.totalItems > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        cartController.totalItems.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const LoadingWidget(message: 'Loading products...');
        }

        if (productController.errorMessage.isNotEmpty) {
          return ErrorView(
            message: productController.errorMessage.value,
            onRetry: productController.fetchProducts,
          );
        }

        if (productController.productList.isEmpty) {
          return const Center(
            child: Text(
              'No products found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await productController.fetchProducts();
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(AppConstants.screenPadding),
            itemCount: productController.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              final product = productController.productList[index];
              return ProductCard(product: product);
            },
          ),
        );
      }),
    );
  }
}