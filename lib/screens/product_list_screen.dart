import 'package:ecommerce_satya/screens/comingSoon_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../app/routes.dart';

import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../widgets/error_view.dart';
import '../widgets/product_card.dart';



class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: _buildAppBar(cartController),
      body: Obx(() {
        if (productController.isLoading.value) {
          return _buildShimmerLoading();
        }
    
        if (productController.errorMessage.isNotEmpty) {
          return ErrorView(
            message: productController.errorMessage.value,
            onRetry: productController.fetchProducts,
          );
        }
    
        if (productController.productList.isEmpty) {
          return const _EmptyProductsView();
        }
    
        return GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          itemCount: productController.productList.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 14,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = productController.productList[index];
            return ProductCard(product: product);
          },
        );
      }),
    );
  }

  Widget _buildShimmerLoading() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 14,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 100,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 16,
                        width: 80,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(CartController cartController) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xffF5F7FB),
      title: Text(
        "Shop",
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: const Color(0xff2F2F2F),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined),
          onPressed: ()=>Get.to(ComingSoon()),
        ),
        const SizedBox(width: 6),
        Obx(() {
          return Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {
                  Get.toNamed(AppRoutes.cart);
                },
              ),
              if (cartController.totalItems > 0)
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xff15B86A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      cartController.totalItems.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
        const SizedBox(width: 10),
      ],
    );
  }
}
class _EmptyProductsView extends StatelessWidget {
  const _EmptyProductsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No products available",
        style: GoogleFonts.passeroOne(
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }
}


