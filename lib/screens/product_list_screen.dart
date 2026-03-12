
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../app/routes.dart';

import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../widgets/error_view.dart';
import '../widgets/product_card.dart';
import 'comingSoon_screen.dart';



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
          // return LoadingWidget(message: 'Product List Loading...',);
          return _buildShimmerLoading();
        }
    
        if (productController.errorMessage.isNotEmpty) {
          return ErrorView(
            message: productController.errorMessage.value,
            onRetry: () => productController.fetchProducts(),
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
        "Product List",
        style: GoogleFonts.passeroOne(
          fontSize: 24,
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
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 42,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),
            Text(
              "No Products Found",
              textAlign: TextAlign.center,
              style: GoogleFonts.passeroOne(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: const Color(0xff333333),
              ),
            ),

            const SizedBox(height: 6),

            /// Subtitle
            Text(
              "We couldn't find any products right now.\nPlease check again later.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.4,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


