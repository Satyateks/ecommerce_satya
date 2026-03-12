import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes.dart';
import '../models/product_model.dart';
import '../utils/constants.dart';
import 'loading_widget.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.cardRadius(context)),
      onTap: () {
        Get.toNamed(
          AppRoutes.productDetail,
          arguments: product,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.cardRadius(context)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      product.image ?? '',
                      height: AppConstants.imageHeight(context),
                      width: double.infinity,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) { return child; }
                        return const Center(child: LoadingWidget());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image_outlined, size: 50);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title ?? 'No Title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                product.category ?? 'Unknown Category',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: 8),
              Text(
                '₹ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                style: AppTextStyles.priceText,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}


