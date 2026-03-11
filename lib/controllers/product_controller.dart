
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductController extends GetxController {

  final ProductService _productService = ProductService();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxList<ProductModel> productList = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      // debugPrint('fetchProducts calling start......');
      final products = await _productService.fetchProducts();
      productList.assignAll(products);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

}