import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/product_remote_data_source.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProducts();
        print('Produk diterima: ${products.length} items');
        return Right(products.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        print('Error dari server: ${e.message}');
        return Left(ServerFailure(e.message));
      } catch (e) {
        print('Unexpected error: $e');
        return Left(ServerFailure('Unexpected error'));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
  @override
  Future<Either<Failure, Map<String, dynamic>>> registerProduct({
    required String title,
    required String description,
    required String price,
    required String stock,
    required String weight,
    required File image,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.registerProduct(
          title: title,
          description: description,
          price: price,
          stock: stock,
          weight: weight,
          image: image,
        );
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}