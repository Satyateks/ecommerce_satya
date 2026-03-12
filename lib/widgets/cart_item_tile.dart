import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/cart_controller.dart';
import '../models/cart_item_model.dart';
import '../utils/constants.dart';


class CartItemTile extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemTile({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    final product = cartItem.product;
    final quantity = cartItem.quantity;
    final unitPrice = product.price ?? 0.0;

    final originalPrice = unitPrice + 1100;

    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.28; 
    final stepperWidth = screenWidth * 0.40;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(28),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height:  screenWidth * 0.40,
                width: imageSize,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffF7F7F7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_not_supported_outlined,
                    size: 38,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? 'No Title',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3A3A3A),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      product.category ?? '8 GB RAM',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.032,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff7A7A7A),
                      ),
                    ),

                    const SizedBox(height: 6),


                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xffF4B400), size: 18),
                        const Icon(Icons.star_rounded,
                            color: Color(0xffF4B400), size: 18),
                        const Icon(Icons.star_rounded,
                            color: Color(0xffF4B400), size: 18),
                        const Icon(Icons.star_rounded,
                            color: Color(0xffF4B400), size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.rating?.count ?? 32})',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.030,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),


                    Row(
                      children: [
                        Text(
                          '₹ ${unitPrice.toStringAsFixed(0)}',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.042,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xffF7EBED),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '₹ ${originalPrice.toStringAsFixed(0)}',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.028,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Text(
                      'Total: ₹ ${(unitPrice * quantity).toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Quantity Stepper
                    Container(
                      height: 46,
                      width: stepperWidth,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {cartController.decreaseQuantity(product.id ?? 0);
                                // cartController.removeFromCart(product.id ?? 0);
                              },
                              child: Icon(quantity == 1 ? Icons.delete_outline_rounded : Icons.remove_rounded),
                            ),
                          ),
                        //  IconButton(
                        //     onPressed: () {
                        //       cartController.decreaseQuantity(product.id ?? 0);
                        //     },
                        //     icon: const Icon(Icons.remove),
                        //   ),
                          Container(width: 1, color: const Color(0xffD8EEDD)),
                          Expanded(
                            child: Center(
                              child: Text(
                                quantity.toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(width: 1, color: const Color(0xffD8EEDD)),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cartController
                                    .increaseQuantity(product.id ?? 0);
                              },
                              child: const Icon(Icons.add_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Delivery Row
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xffEBEBEB)),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_shipping_outlined,
                    color: AppColors.primary, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Delivery by 11 Feb 2026',
                    style: GoogleFonts.poppins(fontSize: 13.5),
                  ),
                ),
                Text(
                  '(2 days)',
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}


