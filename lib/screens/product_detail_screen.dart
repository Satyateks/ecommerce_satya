import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/cart_controller.dart';
import '../models/product_model.dart';
import '../app/routes.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import 'comingSoon_screen.dart';


class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel? product = Get.arguments as ProductModel?;
    
    if (product == null) {
      return Scaffold(
        backgroundColor: const Color(0xffF5F7FB),
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffF4F6FA),
          elevation: 0,
          surfaceTintColor: const Color(0xffF4F6FA),
          title: Row(mainAxisSize: MainAxisSize.min,
            children: [
                IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xff2F2F2F),
                ),
              ),
              Text(
                'Product Details',
                style: GoogleFonts.passeroOne(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2F2F2F),
                ),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                'Product not found',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }
    
    final CartController cartController = Get.find<CartController>();

    final double price = product.price ?? 0.0;
    final double originalPrice = price + 5000;
    final int discountPercent = originalPrice > 0 ? (((originalPrice - price) / originalPrice) * 100).round() : 0;
    final double rating = product.rating?.rate ?? 4.2;
    final int ratingCount = product.rating?.count ?? 32;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _TopImageSection(product: product),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
                      decoration: const BoxDecoration(
                        color: Color(0xffF5F7FB),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BrandCategoryRow(
                            category: product.category ?? 'Category',
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.title ?? 'No Title',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff262626),
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _RatingRow(
                            rating: rating,
                            ratingCount: ratingCount,
                          ),
                          const SizedBox(height: 18),
                          _PriceSection(
                            price: price,
                            originalPrice: originalPrice,
                            discountPercent: discountPercent,
                          ),
                          const SizedBox(height: 18),
                          _OfferStrip(
                            text: 'Special offer applied on this product',
                          ),
                          const SizedBox(height: 20),
                          _InfoChipsRow(
                            items: const [ 'Free Delivery', 'Easy Returns', 'Secure Payment'],
                          ),
                          const SizedBox(height: 24),
                          _SectionTitle(title: 'Product details'),
                          const SizedBox(height: 12),
                          _DetailInfoCard(product: product),
                          const SizedBox(height: 22),
                          _SectionTitle(title: 'Description'),
                          const SizedBox(height: 10),
                          _DescriptionCard(description: product.description ?? 'No description available for this product.'),
                          const SizedBox(height: 22),
                          _SectionTitle(title: 'Why you will like it'),
                          const SizedBox(height: 10),
                          const _HighlightsCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _BottomAddToCartBar(
              price: price,
              onCartTap: ()=> Get.toNamed(AppRoutes.cart),
              onAddToCartTap: () {
                cartController.addToCart(product);
                Get.snackbar(
                  'Added to Cart',
                  'Product added successfully',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: AppColors.success,
                  colorText: const Color(0xffF4F6FA),
                  margin: const EdgeInsets.all(12),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TopImageSection extends StatelessWidget {
  final ProductModel product;
  const _TopImageSection({required this.product });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(34),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 70, 28, 28),
              child: Hero(
                tag: 'product_${product.id}',
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: _CircleIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Get.back(),
            ),
          ),
          Positioned(
            top: 14, right: 64,
            child: _CircleIconButton(
              icon: Icons.favorite_border_rounded,
              onTap: ()=>Get.to(ComingSoon()),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: _CartActionButton(
              onTap: () => Get.toNamed(AppRoutes.cart),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xff303030),
          ),
        ),
      ),
    );
  }
}

class _CartActionButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CartActionButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Obx(
      () => Stack(
        clipBehavior: Clip.none,
        children: [
          _CircleIconButton(
            icon: Icons.shopping_bag_outlined,
            onTap: onTap,
          ),
          if (cartController.totalItems > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 3,
                ),
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
      ),
    );
  }
}

class _BrandCategoryRow extends StatelessWidget {
  final String category;

  const _BrandCategoryRow({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xffE9F8F0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            category.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xff15A862),
              letterSpacing: 0.3,
            ),
          ),
        ),
        const Spacer(),
        Row(
          children: [
            const Icon(
              Icons.local_shipping_outlined,
              size: 18,
              color: Color(0xff3F7AE8),
            ),
            const SizedBox(width: 5),
            Text(
              'Fast Delivery',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xff5E5E5E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  final double rating;
  final int ratingCount;

  const _RatingRow({
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xffFFF7E7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Color(0xffF4B400),
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                rating.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff393939),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$ratingCount ratings',
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xff6B6B6B),
          ),
        ),
      ],
    );
  }
}

class _PriceSection extends StatelessWidget {
  final double price;
  final double originalPrice;
  final int discountPercent;

  const _PriceSection({
    required this.price,
    required this.originalPrice,
    required this.discountPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '₹ ${price.toStringAsFixed(0)}',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: const Color(0xff262626),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            '₹ ${originalPrice.toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xff929292),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xffEAFBF3),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '$discountPercent% OFF',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xff16AF68),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OfferStrip extends StatelessWidget {
  final String text;

  const _OfferStrip({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xffEEF4FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_offer_outlined,
            color: Color(0xff3F7AE8),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xff3D4C6E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChipsRow extends StatelessWidget {
  final List<String> items;

  const _InfoChipsRow({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items
          .map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xffE8E8E8),
                ),
              ),
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff545454),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: const Color(0xff2F2F2F),
      ),
    );
  }
}

class _DetailInfoCard extends StatelessWidget {
  final ProductModel product;

  const _DetailInfoCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _InfoRow(
            label: 'Category',
            value: product.category ?? 'N/A',
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),
          _InfoRow(
            label: 'Availability',
            value: 'In Stock',
            valueColor: const Color(0xff15A862),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),
          _InfoRow(
            label: 'Delivery',
            value: 'Within 2-4 days',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xff6D6D6D),
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? const Color(0xff2F2F2F),
          ),
        ),
      ],
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final String description;

  const _DescriptionCard({required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        description,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xff575757),
          height: 1.75,
        ),
      ),
    );
  }
}

class _HighlightsCard extends StatelessWidget {
  const _HighlightsCard();

  @override
  Widget build(BuildContext context) {
    final items = [
      'Premium quality product with modern design',
      'Trusted by customers for value and reliability',
      'Easy returns and secure checkout experience',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xff15B86A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff565656),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _BottomAddToCartBar extends StatelessWidget {
  final double price;
  final VoidCallback onCartTap;
  final VoidCallback onAddToCartTap;

  const _BottomAddToCartBar({
    required this.price,
    required this.onCartTap,
    required this.onAddToCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Container(
              width: 110,
              height: 62,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xffF7F8FB),
                borderRadius:  BorderRadius.circular(AppConstants.cardRadius(context)),
              ),
              child: Column(mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Price', style: GoogleFonts.poppins(fontSize: 12)),
                  Text(
                    '₹ ${price.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                text: "Add to Cart",
                icon: Icons.add_shopping_cart,
                onPressed: onAddToCartTap,
              ),
            ),
          ],
        )
      ),
    );
  }
}

