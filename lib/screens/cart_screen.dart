import 'package:ecommerce_satya/screens/comingSoon_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../utils/constants.dart';
import '../widgets/cart_item_tile.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_button.dart';





class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xffF4F6FA),
        elevation: 0,
        surfaceTintColor: const Color(0xffF4F6FA),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xff2F2F2F),
            size: 22,
          ),
        ),
        title: Text(
          'Cart',
          style: GoogleFonts.passeroOne(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xff2F2F2F),
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const _ModernEmptyCartView();
        }

        final subtotal = cartController.totalAmount;
        final discount = subtotal >= 1000 ? 500.0 : 0.0;
        final grandTotal = subtotal - discount;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _DeliveryAddressCard(),
                    const SizedBox(height: 14),

                    ...cartController.cartItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: CartItemTile(cartItem: item),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      'Price details',
                      style: GoogleFonts.openSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff353535),
                      ),
                    ),
                    const SizedBox(height: 14),

                    _PriceDetailsCard(
                      itemCount: cartController.totalItems,
                      subtotal: subtotal,
                      discount: discount,
                      grandTotal: grandTotal,
                    ),

                    const SizedBox(height: 28),

                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              color: Color(0xff0FA968),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              color:AppColors.cardBackground,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Safe and secure payments. Easy return.',
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff343434),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 21),
                  ],
                ),
              ),
            ),

            _BottomPaySection(
              payableAmount: grandTotal,
              onTap: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: const BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 48,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              color: Color(0xffEAFBF3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_circle_outline_rounded,
                              color: Color(0xff14B86A),
                              size: 38,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Confirm Payment',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff303030),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Proceed with payment of ₹${grandTotal.toStringAsFixed(0)}?',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff666666),
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Get.back(),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(52),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    cartController.clearCart();
                                    Get.back();
                                    Get.snackbar(
                                      'Success',
                                      'Payment completed successfully',
                                      snackPosition: SnackPosition.TOP,
                                      margin: const EdgeInsets.all(12),
                                      backgroundColor: AppColors.success
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: AppColors.success,
                                    minimumSize: const Size.fromHeight(52),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  child: Text(
                                    'Confirm',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.cardBackground,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  isScrollControlled: true,
                );
              },
            ),
          ],
        );
      }),
    );
  }
}

class _DeliveryAddressCard extends StatelessWidget {
  const _DeliveryAddressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color:AppColors.cardBackground,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              border: Border.all(
                color:AppColors.primary,
                width: 1.8,
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.location_on_outlined,
                color: AppColors.success,
                size: 23,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Greater Noida, Techzone 4',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xff3A3A3A),
              ),
            ),
          ),
          TextButton(onPressed: ()=>Get.to(ComingSoon()), child: 
          Text(
            'Change',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          )),
        ],
      ),
    );
  }
}

class _PriceDetailsCard extends StatelessWidget {
  final int itemCount;
  final double subtotal;
  final double discount;
  final double grandTotal;

  const _PriceDetailsCard({
    required this.itemCount,
    required this.subtotal,
    required this.discount,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffD9D9D9)),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.discount_outlined,
                  color: Color(0xff3F7AE8),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Enter promo code (if any)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          _PriceRow(
            label: 'Price ($itemCount item${itemCount > 1 ? 's' : ''})',
            value: '₹${subtotal.toStringAsFixed(0)}',
            valueColor: const Color(0xff373737),
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: const Color(0xffE7E7E7)),
          const SizedBox(height: 14),
          _PriceRow(
            label: 'Discount',
            value: '-₹${discount.toStringAsFixed(0)}',
            valueColor: const Color(0xff1FB355),
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: const Color(0xffE7E7E7)),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grand total',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff373737),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Including GST',
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff767676),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '₹${grandTotal.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff373737),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _PriceRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xff373737),
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _BottomPaySection extends StatelessWidget {
  final double payableAmount;
  final VoidCallback onTap;

  const _BottomPaySection({
    required this.payableAmount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
      decoration: BoxDecoration(
        color:AppColors.cardBackground,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff6B6B6B),
                ),
                children: const [
                  TextSpan(text: 'By clicking continue i agree to Satya Ecommerce’s '),
                  TextSpan(
                    text: 'T&C',
                    style: TextStyle(
                      color: Color(0xff3F7AE8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Color(0xff3F7AE8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payable amount',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff666666),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₹${payableAmount.toStringAsFixed(0)}',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff2F2F2F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                text: "Proceed to Pay",
                // icon: Icons.add_shopping_cart,
                onPressed: onTap
              ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernEmptyCartView extends StatelessWidget {
  const _ModernEmptyCartView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: const BoxDecoration(
                color: Color(0xffEAFBF3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 52,
                color: Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Your cart is empty',
              style: GoogleFonts.passeroOne(
                fontSize: 27,
                fontWeight: FontWeight.w700,
                color: const Color(0xff303030),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add products to your cart to continue shopping.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff6C6C6C),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: CustomButton(icon: Icons.storefront_outlined,
                text: "Continue Shopping",
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

