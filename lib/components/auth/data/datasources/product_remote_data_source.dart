import 'dart:io';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<Map<String, dynamic>> registerProduct({
    required String title,
    required String description,
    required String price,
    required String stock,
    required String weight,
    required File image,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiService.get(ApiConstants.productsEndpoint);
      final data = response['data']['data'] as List; // Sesuai struktur response API
      return data.map((product) => ProductModel.fromJson(product)).toList();
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> registerProduct({
    required String title,
    required String description,
    required String price,
    required String stock,
    required String weight,
    required File image,
  }) async {
    try {
      final fields = {
        'title': title,
        'description': description,
        'price': price,
        'stock': stock,
        'weight': weight,
      };
      final response = await apiService.postFormData(
        '/product', // The endpoint for product registration
        fields: fields,
        file: image,
        fileFieldName: 'image', // Match this with your backend's expected field name
      );
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}