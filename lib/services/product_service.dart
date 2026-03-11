import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';
import '../utils/constants.dart';

class ProductService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<List<ProductModel>> fetchProducts() async {
    try {
        debugPrint('.........fetchProducts API calling.........');
      final response = await _dio.get(AppConstants.productsEndpoint);
        debugPrint('response .........$response');
      if (response.statusCode == 200) {
        debugPrint('.........${response.data}');
        final List data = response.data as List;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout. Please try again.';
    } else if (e.type == DioExceptionType.sendTimeout) {
      return 'Request send timeout. Please try again.';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Response timeout. Please try again.';
    } else if (e.type == DioExceptionType.badResponse) {
      return 'Server error: ${e.response?.statusCode}';
    } else if (e.type == DioExceptionType.cancel) {
      return 'Request was cancelled.';
    } else if (e.type == DioExceptionType.unknown) {
      return 'No internet connection or unknown error.';
    } else {
      return 'Unexpected network error occurred.';
    }
  }
}