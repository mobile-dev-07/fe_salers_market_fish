import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
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
}